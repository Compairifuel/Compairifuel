package org.compairifuel.compairifuelapi.fuelprice.service;

import jakarta.enterprise.inject.Default;
import jakarta.inject.Inject;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedHashMap;
import jakarta.ws.rs.core.Response;
import lombok.Cleanup;
import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.service.GasStationDomain;
import org.compairifuel.compairifuelapi.gasstation.service.ResultDomain;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

@Default
public class FuelPriceServiceImpl implements IFuelPriceService {
    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private IEnvConfig envConfig;

    @Inject
    public void setEnvConfig(IEnvConfig envConfig) {
        this.envConfig = envConfig;
    }

//    @Deprecated
//    @Override
//    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address) {
//        Logger logger = Logger.getLogger(this.getClass().getName());
//
//        Client client = ClientBuilder.newClient();
//        MultivaluedHashMap<String, Object> headers = new MultivaluedHashMap<>();
//        headers.add("Content-Type", "application/json");
//        headers.add("Accept", "*/*");
//        FuelPriceDomain name = client.target("https://www.tankplanner.nl/api/v1/route/" + fuelType + "/?origin=" + address + "&destination=" + address)
//                .request(MediaType.APPLICATION_JSON).headers(headers).get(FuelPriceDomain.class);
//        client.close();
//
//        logger.info(name.toString());
//
//        return List.of();
//    }

    //   @Deprecated
    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address) {
        String apiKey = envConfig.getEnv("API_KEY");

        @Cleanup Client client = ClientBuilder.newClient();
        MultivaluedHashMap<String, Object> headers = new MultivaluedHashMap<>();
        headers.add("Content-Type", "application/json");
        headers.add("Accept", "*/*");
        WebTarget target = client.target("https://api.tomtom.com/search/2/poiSearch/"+address+".json?key=" + apiKey);
        @Cleanup Response response = target.request(MediaType.APPLICATION_JSON).headers(headers).get(Response.class);
        if(response.getStatus() != 200) {
            logger.severe("Failed to get gas stations from TomTom API. Status code: " + response.getStatus());
            throw new RuntimeException("Failed to get gas stations from TomTom API. Status code: " + response.getStatus());
        }
        GasStationDomain gasStationSearch = response.readEntity(GasStationDomain.class);

        Optional<ResultDomain> dataSourceSearch = gasStationSearch.getResults().stream().filter(e->e.getDataSources()!=null && e.getDataSources().getFuelPrice().toString() != null).findFirst();

        if(dataSourceSearch.isPresent()){
            FuelPriceDomain fuelPriceSearch = client.target("https://api.tomtom.com/search/2/fuelPrice.json?key="+ apiKey +"&fuelPrice="+dataSourceSearch.get().getDataSources().getFuelPrice().toString())
                    .request(MediaType.APPLICATION_JSON).headers(headers).get(FuelPriceDomain.class);
            if(fuelPriceSearch != null){
                logger.info(fuelPriceSearch.toString());

                List<FuelPriceResponseDTO> fuelPriceResponseDTOList = new ArrayList<>();
                fuelPriceResponseDTOList.add(new FuelPriceResponseDTO(new PositionDTO(dataSourceSearch.get().getPosition().getLat(),dataSourceSearch.get().getPosition().getLon()),address,fuelPriceSearch.getFuels().stream().filter(e->e.getType().equals(fuelType)).findFirst().get().getPrice().get(0).getValue()));

                return fuelPriceResponseDTOList;
            } else {
                logger.info("Fuel price not found");
            }
        } else {
            logger.info("Fuel price not found");
        }

        client.close();
        return List.of();
    }
}