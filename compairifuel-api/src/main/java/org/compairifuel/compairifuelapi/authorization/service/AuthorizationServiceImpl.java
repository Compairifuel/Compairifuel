package org.compairifuel.compairifuelapi.authorization.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import jakarta.enterprise.inject.Default;
import jakarta.inject.Inject;
import jakarta.ws.rs.ForbiddenException;
import jakarta.ws.rs.InternalServerErrorException;
import jakarta.ws.rs.core.UriBuilder;
import lombok.extern.java.Log;
import org.apache.commons.codec.digest.DigestUtils;
import org.compairifuel.compairifuelapi.authorization.presentation.AccessTokenResponseDTO;
import org.compairifuel.compairifuelapi.authorization.service.domain.AccessTokenDomain;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;

import javax.crypto.SecretKey;
import java.net.URI;
import java.util.Arrays;
import java.util.Date;

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

        if (!redirectToURI.clone().replaceQuery("").build().toString().equals("abc://a")) {
            log.warning("The redirect url isn't whitelisted!");
            throw new ForbiddenException();
        }

        String secretKey = envConfig.getEnv("SECRET_KEY");
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        SecretKey key = Keys.hmacShaKeyFor(keyBytes);

        long expiresIn = 36000;

        String authorizationCode = Jwts
                .builder()
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + expiresIn))
                .claim("state", state)
                .claim("code_challenge", codeChallenge)
                .claim("redirect_uri", redirectUri)
                .claim("grant_type", grantType)
                .signWith(key)
                .compact();

        return redirectToURI
            .queryParam("state", state)
            .queryParam("authorization_code", authorizationCode)
            .build();
    }

    @Override
    public AccessTokenDomain getAccessToken(String grantType, String authorizationCode, String redirectUri, String codeVerifier) {
        String secretKey = envConfig.getEnv("SECRET_KEY");
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        SecretKey key = Keys.hmacShaKeyFor(keyBytes);

        Claims claims;

        try {
            claims = Jwts
                    .parser()
                    .verifyWith(key)
                    .build()
                    .parseSignedClaims(authorizationCode)
                    .getPayload();
        } catch (SignatureException ex) {
            log.warning("The token is not valid: " + ex.getMessage());
            throw new ForbiddenException();
        } catch (ExpiredJwtException ex) {
            log.warning("The token has expired: " + ex.getMessage());
            throw new ForbiddenException();
        } catch (JwtException ex) {
            log.severe("An error occured during the Jwts parser: " + ex.getMessage() + " " + ex.getCause() + " " + Arrays.toString(ex.getStackTrace()));
            throw new InternalServerErrorException();
        }

        if (!DigestUtils.sha256Hex(codeVerifier).equals(claims.get("code_challenge", String.class)) ||
                !redirectUri.equals(claims.get("redirect_uri", String.class))
        ) {
            log.warning("The code is not the same or the redirect Uri is not the same!");
            throw new ForbiddenException();
        }

        long expiresIn = 3600000;

        String accessToken = Jwts
                .builder()
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + expiresIn))
                .signWith(key)
                .compact();

        String refreshToken = Jwts
                .builder()
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + (expiresIn * 2)))
                .claim("code_challenge", claims.get("code_challenge", String.class))
                .signWith(key)
                .compact();

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

        Claims claims;

        try {
            claims = Jwts
                    .parser()
                    .verifyWith(key)
                    .build()
                    .parseSignedClaims(refreshToken)
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

        if (!DigestUtils.sha256Hex(codeVerifier).equals(claims.get("code_challenge", String.class))) {
            log.warning("The code is not the same or the refresh token is not valid!");
            throw new ForbiddenException();
        }

        long expiresIn = 3600000;

        String accessToken = Jwts
                .builder()
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + expiresIn))
                .signWith(key)
                .compact();

        String newRefreshToken = Jwts
                .builder()
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + (expiresIn * 2)))
                .claim("code_challenge", claims.get("code_challenge", String.class))
                .signWith(key)
                .compact();

        AccessTokenDomain response = new AccessTokenDomain();
        response.setAccessToken(accessToken);
        response.setExpiresIn(expiresIn);
        response.setTokenType(TOKEN_TYPE);
        response.setRefreshToken(refreshToken);

        return response;
    }
}
