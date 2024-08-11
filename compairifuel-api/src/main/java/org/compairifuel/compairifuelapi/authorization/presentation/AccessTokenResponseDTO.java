package org.compairifuel.compairifuelapi.authorization.presentation;

import lombok.Data;

@Data
public class AccessTokenResponseDTO {
    private String access_token;
    private String token_type;
    private Long expires_in;
    private String refresh_token;

}
