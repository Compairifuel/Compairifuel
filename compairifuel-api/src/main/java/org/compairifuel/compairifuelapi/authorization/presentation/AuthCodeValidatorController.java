package org.compairifuel.compairifuelapi.authorization.presentation;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import jakarta.inject.Inject;
import jakarta.ws.rs.ForbiddenException;
import jakarta.ws.rs.InternalServerErrorException;
import lombok.extern.java.Log;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;

import javax.crypto.SecretKey;
import java.util.Arrays;

@Log(topic = "AuthCodeValidatorController")
public class AuthCodeValidatorController {
    private IEnvConfig envConfig;

    @Inject
    public void setEnvConfig(IEnvConfig envConfig) {
        this.envConfig = envConfig;
    }

    public boolean authenticateToken(String accessToken) {
        //check expired dates and signature

        String secretKey = envConfig.getEnv("SECRET_KEY");
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        SecretKey key = Keys.hmacShaKeyFor(keyBytes);

        try {
            Jwts
                    .parser()
                    .verifyWith(key)
                    .build()
                    .parseSignedClaims(accessToken)
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
        return true;
    }
}
