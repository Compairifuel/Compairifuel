package org.compairifuel.compairifuelapi.authorization.service.domain;

import lombok.Data;

import java.net.URI;

@Data
public class AuthorizationCodeDomain {
    private String authorizationCode;
    private URI redirectToUri;
}
