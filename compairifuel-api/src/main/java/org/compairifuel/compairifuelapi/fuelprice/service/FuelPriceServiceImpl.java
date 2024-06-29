package org.compairifuel.compairifuelapi.fuelprice.service;

import jakarta.enterprise.inject.Default;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedHashMap;
import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;

import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@Default
public class FuelPriceServiceImpl implements IFuelPriceService {
    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address) {
        Logger logger = Logger.getLogger(this.getClass().getName());

        Client client = ClientBuilder.newClient();
        MultivaluedHashMap<String, Object> headers = new MultivaluedHashMap<>();
        headers.add("Content-Type", "application/json");
        headers.add("Accept", "*/*");
        FuelPriceDomain name = client.target("https://www.tankplanner.nl/api/v1/route/" + fuelType + "/?origin=" + address + "&destination=" + address)
                .request(MediaType.APPLICATION_JSON).headers(headers).get(FuelPriceDomain.class);
        client.close();

        logger.info(name);

        return List.of();
    }
}
