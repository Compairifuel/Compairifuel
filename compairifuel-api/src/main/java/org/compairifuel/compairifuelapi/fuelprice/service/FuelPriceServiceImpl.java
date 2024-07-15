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
import lombok.extern.java.Log;
import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.service.domain.GasStationDomain;
import org.compairifuel.compairifuelapi.gasstation.service.domain.ResultDomain;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;
import org.compairifuel.compairifuelapi.utils.service.IServiceHttpClient;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

@Log(topic = "FuelPriceServiceImpl")
@Default
public class FuelPriceServiceImpl implements IFuelPriceService {
    private IEnvConfig envConfig;
    private IServiceHttpClient serviceHttpClient;
    private IFuelPriceServiceAggregatorAdapter fuelPriceServiceAggregatorAdapter;

    @Inject
    public void setFuelPriceServiceAggregatorAdapter(IFuelPriceServiceAggregatorAdapter fuelPriceServiceAggregatorAdapter) {
        this.fuelPriceServiceAggregatorAdapter = fuelPriceServiceAggregatorAdapter;
    }

    @Inject
    public void setServiceHttpClient(IServiceHttpClient serviceHttpClient) {
        this.serviceHttpClient = serviceHttpClient;
    }

    @Inject
    public void setEnvConfig(IEnvConfig envConfig) {
        this.envConfig = envConfig;
    }

    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address) {
        try {
            return fuelPriceServiceAggregatorAdapter.getPrices(fuelType, address);
        } catch (Exception e) {
            log.info("Error while getting prices: " + e.getMessage());
        }
        return List.of();
    }

//    @Deprecated
//    @Override
//    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address) {
//        MultivaluedHashMap<String, Object> queryParams = new MultivaluedHashMap<>();
//        queryParams.add("origin", address);
//        queryParams.add("destination", address);
//        FuelPriceDomain name = serviceHttpClient.sendRequest("https://www.tankplanner.nl/api/v1/route/" + fuelType + "/", queryParams, FuelPriceDomain.class);
//        log.info(name.toString());
//
//        return List.of();
//    }

//    @Deprecated
//    @Override
//    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address) {
//        String apiKey = envConfig.getEnv("API_KEY");
//
//        MultivaluedHashMap<String, Object> queryParams = new MultivaluedHashMap<>();
//        queryParams.add("key", apiKey);
//        GasStationDomain gasStationSearch = serviceHttpClient.sendRequest("https://api.tomtom.com/search/2/poiSearch/" + address + ".json", queryParams, GasStationDomain.class);
//
//        Optional<ResultDomain> dataSourceSearch = gasStationSearch.getResults().stream().filter(e -> e.getDataSources() != null && e.getDataSources().getFuelPrice().toString() != null).findFirst();
//
//        if (dataSourceSearch.isPresent()) {
//            queryParams = new MultivaluedHashMap<>();
//            queryParams.add("key", apiKey);
//            queryParams.add("fuelPrice", dataSourceSearch.get().getDataSources().getFuelPrice().toString());
//            FuelPriceDomain fuelPriceSearch = serviceHttpClient.sendRequest("https://api.tomtom.com/search/2/fuelPrice.json", queryParams, FuelPriceDomain.class);
//            if (fuelPriceSearch != null) {
//                log.info(fuelPriceSearch.toString());
//
//                List<FuelPriceResponseDTO> fuelPriceResponseDTOList = new ArrayList<>();
//                fuelPriceResponseDTOList.add(new FuelPriceResponseDTO(new PositionDTO(dataSourceSearch.get().getPosition().getLat(), dataSourceSearch.get().getPosition().getLon()), address, fuelPriceSearch.getFuels().stream().filter(e -> e.getType().equals(fuelType)).findFirst().get().getPrice().get(0).getValue()));
//
//                return fuelPriceResponseDTOList;
//            } else {
//                log.info("Fuel price not found");
//            }
//        } else {
//            log.info("No Data Source present " + gasStationSearch.getSummary());
//        }
//
//        return List.of();
//    }
}