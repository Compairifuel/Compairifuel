package org.compairifuel.compairifuelapi.fuelprice.presentation;

import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.compairifuel.compairifuelapi.fuelprice.service.IFuelPriceService;

import java.util.List;

@Path("")
public class FuelPriceController {
    private IFuelPriceService fuelPriceService;

    @Inject
    public void setFuelPriceService(IFuelPriceService fuelPriceService) {
        this.fuelPriceService = fuelPriceService;
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/prices/{fuelType}/{address}")
    public Response getPrices(@PathParam("fuelType") String fuelType, @PathParam("address") String address) {
        List<FuelPriceResponseDTO> prices = fuelPriceService.getPrices(fuelType, address);
        return Response.ok().entity(prices).build();
    }
}
