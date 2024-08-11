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
//    private final String code_challenge = "2369850d2ab1338387f111660c108329b2cc66ca5f30e872ef7ca24d79b66347"; // SHA256 hash
//    private final String code_verifier = "YWJjc2Rhc2Rhc2Fkc2Fkc2Fkc2FkZHNhc2Fkc2Fkc2Rhc2Rhc2Fkc2Fkc2Fkc2Fkc2Fkc2Fkc2Fk"; // Base64-URL-encoded

    @Inject
    public void setEnvConfig(IEnvConfig envConfig) {
        this.envConfig = envConfig;
    }

    @Override
    public URI getAuthorizationCode(String grantType, String redirectUri, String codeChallenge, String state) {
        /* TODO:
         -  if it is a valid redirect URL for this application. (does not match one of the registered redirect URLs for the application)
         -  if invalid redirect URL then return error and not redirect.
         -  store state, PKCE, redirect URL and authorization_code.
         */

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
        /* TODO:
         -  if the authorization code is valid, and has not expired.
         -  if the authorization code is previously received from the authorization request.
         -  if the redirect URI matches the redirect URI that was included in the initial authorization request.
         -  if the code verifier can be used to verify the hash that was included in the initial authorization request.
         -  generate access token.
         */

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
        /* TODO:
         -  the refresh token is valid, and has not expired.
         -  generate an access token.
         */

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
