package org.compairifuel.compairifuelapi.gasstation.presentation;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("")
public class GasStationController {

    @GET
    @Path("/gasStations/{lat}/{lng}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getGasStations(@PathParam("lat") double latitude, @PathParam("lng") double longitude, @QueryParam("radius") int radius) {
        return Response.ok().entity("WOW").build();
    }
}
