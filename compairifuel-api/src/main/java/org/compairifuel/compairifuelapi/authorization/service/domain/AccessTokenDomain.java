package org.compairifuel.compairifuelapi.authorization.service.domain;

import lombok.Data;

@Data
public class AccessTokenDomain {
    private String accessToken;
    private String tokenType;
    private long expiresIn;
    private String refreshToken;
}
