package org.compairifuel.compairifuelapi.gasstation.presentation;

import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.compairifuel.compairifuelapi.authorization.presentation.AuthCodeValidatorController;
import org.compairifuel.compairifuelapi.gasstation.service.IGasStationService;

import java.util.List;

@Path("")
public class GasStationController {
    private IGasStationService gasStationService;
    private AuthCodeValidatorController authCodeValidatorController;

    @Inject
    public void setGasStationService(IGasStationService gasStationService) {
        this.gasStationService = gasStationService;
    }

    @Inject
    public void setAuthCodeValidatorController(AuthCodeValidatorController authCodeValidatorController){
        this.authCodeValidatorController = authCodeValidatorController;
    }

    @GET
    @Path("/gasStations/{lat}/{lng}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getGasStations(@PathParam("lat") double latitude, @PathParam("lng") double longitude, @HeaderParam("Authorization") String authorization) {
        authCodeValidatorController.authenticateToken(authorization.replace("Bearer","").trim());

        List<GasStationResponseDTO> gasStationEntities = gasStationService.getGasStations(latitude, longitude, 25000);
        return Response.ok().entity(gasStationEntities).build();
    }
}