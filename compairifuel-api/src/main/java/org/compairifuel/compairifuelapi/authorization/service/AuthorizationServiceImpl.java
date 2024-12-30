package org.compairifuel.compairifuelapi.authorization.service;

import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import jakarta.enterprise.inject.Default;
import jakarta.inject.Inject;
import jakarta.ws.rs.ForbiddenException;
import jakarta.ws.rs.InternalServerErrorException;
import jakarta.ws.rs.core.UriBuilder;
import lombok.Cleanup;
import lombok.extern.java.Log;
import org.apache.commons.codec.digest.DigestUtils;
import org.compairifuel.compairifuelapi.authorization.service.domain.AccessTokenDomain;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;

import javax.crypto.SecretKey;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.util.*;

@Log(topic = "AuthorizationServiceImpl")
@Default
public class AuthorizationServiceImpl implements IAuthorizationService {
    private IEnvConfig envConfig;
    private final String TOKEN_TYPE = "Bearer";

    @Inject
    public void setEnvConfig(IEnvConfig envConfig) {
        this.envConfig = envConfig;
    }

    @Override
    public URI getAuthorizationCode(String grantType, String redirectUri, String codeChallenge, String state) {
        UriBuilder redirectToURI = UriBuilder.fromUri(redirectUri);

        boolean isWhitelisted;
        try {
            @Cleanup BufferedReader br = new BufferedReader(new InputStreamReader(Objects.requireNonNull(getClass().getClassLoader().getResourceAsStream("whitelisted_uri.yml"))));
            isWhitelisted = br.lines().anyMatch((el) -> Objects.equals(el, redirectToURI.clone().replaceQuery("").build().toString()));
        } catch (Exception e) {
            throw new InternalServerErrorException(e.getMessage());
        }

        if (!isWhitelisted) {
            log.warning("The redirect url isn't whitelisted!");
            throw new ForbiddenException();
        }

        long expiresIn = 36000;

        var hashMap = new HashMap<String, Object>();
        hashMap.put("state", state);
        hashMap.put("code_challenge", codeChallenge);
        hashMap.put("redirect_uri", redirectUri);
        hashMap.put("grant_type", grantType);
        String authorizationCode = createJwtsToken(hashMap, new Date(System.currentTimeMillis() + expiresIn), new Date(System.currentTimeMillis()));

        return redirectToURI
                .queryParam("state", state)
                .queryParam("code", authorizationCode)
                .build();
    }

    @Override
    public AccessTokenDomain getAccessToken(String grantType, String authorizationCode, String redirectUri, String codeVerifier) {
        String secretKey = envConfig.getEnv("SECRET_KEY");
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        SecretKey key = Keys.hmacShaKeyFor(keyBytes);

        Claims claims = retrieveJwtsClaims(authorizationCode);

        if (!Arrays.equals(Base64.getUrlDecoder().decode(claims.get("code_challenge", String.class)), DigestUtils.sha256(codeVerifier)) ||
                !redirectUri.equals(claims.get("redirect_uri", String.class))
        ) {
            log.warning("The code is not the same or the redirect Uri is not the same!");
            throw new ForbiddenException();
        }

        long expiresIn = 3600000;

        String accessToken = createJwtsToken(new HashMap<>(), new Date(System.currentTimeMillis() + expiresIn), new Date(System.currentTimeMillis()));

        HashMap<String, Object> refreshTokenMap = new HashMap<>();
        refreshTokenMap.put("code_challenge", claims.get("code_challenge", String.class));
        String refreshToken = createJwtsToken(refreshTokenMap, new Date(System.currentTimeMillis() + (expiresIn * 2)), new Date(System.currentTimeMillis()));

        AccessTokenDomain response = new AccessTokenDomain();
        response.setAccessToken(accessToken);
        response.setExpiresIn(expiresIn);
        response.setTokenType(TOKEN_TYPE);
        response.setRefreshToken(refreshToken);

        return response;
    }

    @Override
    public AccessTokenDomain getAccessTokenByRefreshToken(String grantType, String refreshToken, String codeVerifier) {
        String secretKey = envConfig.getEnv("SECRET_KEY");
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        SecretKey key = Keys.hmacShaKeyFor(keyBytes);

        Claims claims = retrieveJwtsClaims(refreshToken);

        if (!Arrays.equals(Base64.getUrlDecoder().decode(claims.get("code_challenge", String.class)), DigestUtils.sha256(codeVerifier))) {
            log.warning("The code is not the same or the refresh token is not valid!");
            throw new ForbiddenException();
        }

        long expiresIn = 3600000;

        String accessToken = createJwtsToken(new HashMap<>(), new Date(System.currentTimeMillis() + expiresIn), new Date(System.currentTimeMillis()));

        HashMap<String, Object> refreshTokenMap = new HashMap<>();
        refreshTokenMap.put("code_challenge", claims.get("code_challenge", String.class));
        String newRefreshToken = createJwtsToken(refreshTokenMap, new Date(System.currentTimeMillis() + (expiresIn * 2)), new Date(System.currentTimeMillis()));

        AccessTokenDomain response = new AccessTokenDomain();
        response.setAccessToken(accessToken);
        response.setExpiresIn(expiresIn);
        response.setTokenType(TOKEN_TYPE);
        response.setRefreshToken(newRefreshToken);

        return response;
    }

    private Claims retrieveJwtsClaims(String JwtToken) {
        Claims claims;
        try {
            claims = Jwts
                    .parser()
                    .verifyWith(getSecretKey())
                    .build()
                    .parseSignedClaims(JwtToken)
                    .getPayload();
        } catch (SignatureException ex) {
            log.warning("The token is not valid: " + ex.getMessage());
            throw new ForbiddenException();
        } catch (ExpiredJwtException ex) {
            log.warning("The token has expired: " + ex.getMessage());
            throw new ForbiddenException();
        } catch (JwtException ex) {
            log.severe("An error occured during the Jwts parser: " + ex.getMessage());
            throw new InternalServerErrorException();
        }

        return claims;
    }
    private String createJwtsToken(HashMap<String, Object> claims, Date expiration, Date issuedAt) {
        return Jwts.builder().claims(claims).signWith(getSecretKey()).expiration(expiration).issuedAt(issuedAt).compact();
    }

    private SecretKey getSecretKey() {
        String secretKey = envConfig.getEnv("SECRET_KEY");
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        return Keys.hmacShaKeyFor(keyBytes);
    }
}
