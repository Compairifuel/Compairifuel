package org.compairifuel.compairifuelapi.authorization.service;

import org.compairifuel.compairifuelapi.authorization.service.domain.AccessTokenDomain;

import java.net.URI;

public interface IAuthorizationService {
    URI getAuthorizationCode(String grantType, String redirectUri, String codeChallenge, String state);
    AccessTokenDomain getAccessToken(String grantType, String authorizationCode, String redirectUri, String codeVerifier);
    AccessTokenDomain getAccessTokenByRefreshToken(String grantType, String refreshToken, String codeVerifier);
}
