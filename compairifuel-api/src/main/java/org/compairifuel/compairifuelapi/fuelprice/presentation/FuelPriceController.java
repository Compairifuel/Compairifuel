package org.compairifuel.compairifuelapi.fuelprice.presentation;

import jakarta.inject.Inject;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.compairifuel.compairifuelapi.authorization.presentation.AuthCodeValidatorController;
import org.compairifuel.compairifuelapi.fuelprice.service.IFuelPriceService;

import java.util.List;

@Path("")
public class FuelPriceController {
    private IFuelPriceService fuelPriceService;
    private AuthCodeValidatorController authCodeValidatorController;

    @Inject
    public void setFuelPriceService(IFuelPriceService fuelPriceService) {
        this.fuelPriceService = fuelPriceService;
    }

    @Inject
    public void setAuthCodeValidatorController(AuthCodeValidatorController authCodeValidatorController){
        this.authCodeValidatorController = authCodeValidatorController;
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/prices/{fuelType}/{address}")
    public Response getPrices(@PathParam("fuelType") String fuelType, @PathParam("address") String address, @HeaderParam("Authorization") String authorization) {
        authCodeValidatorController.authenticateToken(authorization);

        List<FuelPriceResponseDTO> prices = fuelPriceService.getPrices(fuelType, address);
        return Response.ok().entity(prices).build();
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/prices/{fuelType}/{latitude}/{longitude}")
    public Response getPrices(@PathParam("fuelType") String fuelType, @PathParam("latitude") @Min(value=-180,message="latitude cannot be less than -180.") @Max(value=180,message="latitude cannot be greater that 180.") double latitude, @PathParam("longitude") @Min(value=-180,message="longitude cannot be less than -180.") @Max(value=180,message="longitude cannot be greater that 180.") double longitude, @HeaderParam("Authorization") String authorization) {
        authCodeValidatorController.authenticateToken(authorization);

        List<FuelPriceResponseDTO> prices = fuelPriceService.getPrices(fuelType, latitude, longitude);
        return Response.ok().entity(prices).build();
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/prices/{fuelType}/{address}/{latitude}/{longitude}")
    public Response getPrices(@PathParam("fuelType") String fuelType,@PathParam("address") String address, @PathParam("latitude") @Min(value=-180,message="latitude cannot be less than -180.") @Max(value=180,message="latitude cannot be greater that 180.") double latitude, @PathParam("longitude") @Min(value=-180,message="longitude cannot be less than -180.") @Max(value=180,message="longitude cannot be greater that 180.") double longitude, @HeaderParam("Authorization") String authorization) {
        authCodeValidatorController.authenticateToken(authorization);

        List<FuelPriceResponseDTO> prices = fuelPriceService.getPrices(fuelType, address, latitude, longitude);
        return Response.ok().entity(prices).build();
    }
}
