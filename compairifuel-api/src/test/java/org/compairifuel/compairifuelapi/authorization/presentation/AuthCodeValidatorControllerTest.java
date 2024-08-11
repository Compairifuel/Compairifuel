package org.compairifuel.compairifuelapi.authorization.presentation;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.io.Encoders;
import io.jsonwebtoken.security.Keys;
import jakarta.ws.rs.ForbiddenException;
import jakarta.ws.rs.InternalServerErrorException;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import javax.crypto.SecretKey;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class AuthCodeValidatorControllerTest {
    private final AuthCodeValidatorController sut = new AuthCodeValidatorController();
    private SecretKey key;

    @BeforeEach
    void SetUp() {
        IEnvConfig envConfig = mock(IEnvConfig.class);
        sut.setEnvConfig(envConfig);

        try{
            var random = SecureRandom.getInstanceStrong();
            random.setSeed(4321);
            var temp = Encoders.BASE64.encode(random.generateSeed(256));

            when(envConfig.getEnv("SECRET_KEY")).thenReturn(temp);
            key = Keys.hmacShaKeyFor(Decoders.BASE64.decode(temp));
        }
        catch(NoSuchAlgorithmException e){
            var temp = Encoders.BASE64.encode(new byte[256]);

            when(envConfig.getEnv("SECRET_KEY")).thenReturn(temp);
            key = Keys.hmacShaKeyFor(Decoders.BASE64.decode(temp));
        }

    }

    @Test
    void authenticateTokenReturnsTrue() {
        // Arrange
        final long expiresIn = 3600000;
        String accessToken = Jwts
                .builder()
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + expiresIn))
                .signWith(key)
                .compact();

        // Assert
        assertDoesNotThrow(()->{
            // Act
            boolean result = sut.authenticateToken(accessToken);

            // Assert
            assertTrue(result);
        });
    }

    @Test
    void authenticateTokenThrowsForbiddenExceptionWhenInvalidToken() {
        // Arrange
        var key = Keys.hmacShaKeyFor(Decoders.BASE64.decode(Encoders.BASE64.encode(new byte[258])));

        final long expiresIn = 3600000;
        String accessToken = Jwts
                .builder()
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis()+expiresIn))
                .signWith(key)
                .compact();

        // Assert
        assertThrowsExactly(ForbiddenException.class, ()->{
            // Act
            sut.authenticateToken(accessToken);
        });
    }

    @Test
    void authenticateTokenThrowsForbiddenExceptionWhenExpiredToken() {
        // Arrange
        final long expiresIn = -1;
        String accessToken = Jwts
                .builder()
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + expiresIn))
                .signWith(key)
                .compact();

        // Assert
        assertThrowsExactly(ForbiddenException.class, ()->{
            // Act
            sut.authenticateToken(accessToken);
        });
    }

    @Test
    void authenticateTokenThrowsInternalServerErrorException() {
        // Arrange
        String accessToken = Jwts.builder().signWith(key).compact();

        // Assert
        assertThrowsExactly(InternalServerErrorException.class, ()->{
            // Act
            sut.authenticateToken(accessToken);
        });
    }
}
