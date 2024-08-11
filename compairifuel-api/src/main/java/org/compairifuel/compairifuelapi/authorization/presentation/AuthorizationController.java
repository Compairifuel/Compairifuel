package org.compairifuel.compairifuelapi.authorization.presentation;

import jakarta.inject.Inject;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.net.URI;

import lombok.extern.java.Log;
import org.compairifuel.compairifuelapi.authorization.service.IAuthorizationService;
import org.compairifuel.compairifuelapi.authorization.service.domain.AccessTokenDomain;

@Log(topic = "AuthorizationController")
@Path("/oauth")
public class AuthorizationController {
    private IAuthorizationService authorizationService;

    @Inject
    public void setAuthorizationService(IAuthorizationService authorizationService) {
        this.authorizationService = authorizationService;
    }

    /**
     * @param redirect_uri   A Redirect URI.
     * @param code_challenge A SHA256 hash required for PKCE support.
     * @return
     */
    @GET
    @Path("")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAuthorizationCode(@QueryParam("grant_type") @Pattern(regexp = "(code)", message = "grant_type must be set to “code”.") String grant_type, @QueryParam("redirect_uri") @Pattern(regexp = "^([a-zA-Z]{2,}://[\\w_-]+(\\.[\\w_-]+)?([\\w.,@?^=%&:/~+#-]*[\\w@?^=%&/~+#-])?)$", message = "redirect_uri must be a valid uri") @NotBlank(message = "redirect_uri cannot be blank!") String redirect_uri, @QueryParam("code_challenge") @Pattern(regexp = "^[a-fA-F0-9]{64}$", message = "code_challenge must be a hash!") @NotBlank(message = "code_challenge cannot be blank!") String code_challenge, @QueryParam("state") @NotBlank(message = "state cannot be blank!") String state) {
        URI redirectToURI = authorizationService.getAuthorizationCode(grant_type, redirect_uri, code_challenge, state);
        return Response.seeOther(redirectToURI).header("Cache-Control", "no-store").build();
    }

    /**
     * @param grant_type         The grant_type parameter must be set to “authorization_code”.
     * @param authorization_code This parameter is the authorization code that the client previously received from the authorization request.
     * @param redirect_uri       If the redirect URI was included in the initial authorization request, the service must require it in the token request as well.
     *                           The redirect URI in the token request must be an exact match of the redirect URI that was used when generating the authorization code.
     *                           The service must reject the request otherwise.
     * @param code_verifier      A plaintext string to prove it has the secret used to generate hash of the code_challenge parameter used in the authorization request.
     * @return
     */
    @POST
    @Path("/token")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAccessToken(@QueryParam("grant_type") @Pattern(regexp = "(authorization_code)", message = "grant_type must be set to “authorization_code”.") String grant_type, @QueryParam("authorization_code") @NotBlank(message = "authorization_code cannot be blank!") String authorization_code, @QueryParam("redirect_uri") @Pattern(regexp = "^([a-zA-Z]{2,}://[\\w_-]+(\\.[\\w_-]+)?([\\w.,@?^=%&:/~+#-]*[\\w@?^=%&/~+#-])?)$", message = "redirect_uri must be a valid uri") @NotBlank(message = "redirect_uri cannot be blank!") String redirect_uri, @QueryParam("code_verifier") @Pattern(regexp = "^[-_A-Za-z0-9]{43,128}$", message = "code_verifier must be BASE64-URL-encoded!") @NotBlank(message = "code_verifier cannot be blank!") String code_verifier) {
        AccessTokenDomain accessTokenDomain = authorizationService.getAccessToken(grant_type, authorization_code, redirect_uri, code_verifier);

        AccessTokenResponseDTO response = new AccessTokenResponseDTO();
        response.setAccess_token(accessTokenDomain.getAccessToken());
        response.setExpires_in(accessTokenDomain.getExpiresIn());
        response.setToken_type(accessTokenDomain.getTokenType());
        response.setRefresh_token(accessTokenDomain.getRefreshToken());

        return Response.ok().entity(response).header("Cache-Control", "no-store").build();
    }

    /**
     * @param grant_type    The grant_type parameter must be set to “refresh_token”.
     * @param refresh_token The refresh token received from the previous access token.
     * @return
     */
    @GET
    @Path("/refresh")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAccessTokenByRefreshToken(@QueryParam("grant_type") @Pattern(regexp = "(refresh_token)", message = "grant_type must be set to “refresh_token”.") String grant_type, @QueryParam("refresh_token") @NotBlank(message = "refresh_token cannot be blank!") String refresh_token, @QueryParam("code_verifier") @Pattern(regexp = "^[-_A-Za-z0-9]{43,128}$", message = "code_verifier must be BASE64-URL-encoded!") @NotBlank(message = "code_verifier cannot be blank!") String code_verifier) {
        AccessTokenDomain accessTokenDomain = authorizationService.getAccessTokenByRefreshToken(grant_type, refresh_token, code_verifier);

        AccessTokenResponseDTO response = new AccessTokenResponseDTO();
        response.setAccess_token(accessTokenDomain.getAccessToken());
        response.setExpires_in(accessTokenDomain.getExpiresIn());
        response.setToken_type(accessTokenDomain.getTokenType());
        response.setRefresh_token(accessTokenDomain.getRefreshToken());

        return Response.ok().entity(response).header("Cache-Control", "no-store").build();
    }
}
