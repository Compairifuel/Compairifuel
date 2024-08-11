package org.compairifuel.compairifuelapi.authorization.presentation;

import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;

import javax.crypto.SecretKey;

public class AuthCodeValidatorControllerTest {
    private final AuthCodeValidatorControllerTest sut = new AuthCodeValidatorControllerTest();
    private final String accessToken = "";
    private final String secretKey = "SECRET_KEY";
    byte[] keyBytes = Decoders.BASE64.decode(secretKey);
    SecretKey key = Keys.hmacShaKeyFor(keyBytes);


}
