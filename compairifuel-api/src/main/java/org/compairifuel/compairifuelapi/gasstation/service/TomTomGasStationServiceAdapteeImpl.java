package org.compairifuel.compairifuelapi.gasstation.service;

import jakarta.enterprise.inject.Default;
import jakarta.inject.Inject;
import jakarta.ws.rs.core.MultivaluedHashMap;
import lombok.extern.java.Log;
import org.compairifuel.compairifuelapi.gasstation.mapper.IGasStationMapper;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.service.domain.GasStationDomain;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;
import org.compairifuel.compairifuelapi.utils.service.IServiceHttpClient;

import java.util.List;
import java.util.stream.Collectors;

@Log(topic = "TomTomGasStationServiceAdapteeImpl")
@Default
public class TomTomGasStationServiceAdapteeImpl implements IGasStationsServiceAggregatorAdapter {
    private IServiceHttpClient serviceHttpClient;
    private IEnvConfig envConfig;
    private IGasStationMapper gasStationMapper;

    @Inject
    public void setGasStationMapper(IGasStationMapper gasStationMapper){
        this.gasStationMapper = gasStationMapper;
    }

    @Inject
    public void setEnvConfig(IEnvConfig envConfig) {
        this.envConfig = envConfig;
    }

    @Inject
    public void setServiceHttpClient(IServiceHttpClient serviceHttpClient) {
        this.serviceHttpClient = serviceHttpClient;
    }

    @Override
    public List<GasStationResponseDTO> getGasStations(double latitude, double longitude, int radius) {
        String apiKey = envConfig.getEnv("API_KEY");

        MultivaluedHashMap<String, Object> queryParams = new MultivaluedHashMap<>();
        queryParams.add("key", apiKey);
        queryParams.add("lat", latitude);
        queryParams.add("lon", longitude);
        queryParams.add("radius", radius);
        queryParams.add("categorySet", 7311);
        queryParams.add("relatedPois", "off");
        queryParams.add("limit", 100);
        queryParams.add("countrySet", "NLD,BEL,DEU");
        queryParams.add("minFuzzyLevel", 2);
        queryParams.add("maxFuzzyLevel", 4);

        GasStationDomain gasStationSearch = serviceHttpClient.sendRequest(
                "https://api.tomtom.com/search/2/nearbySearch/.json", queryParams, GasStationDomain.class
        );

        return gasStationSearch.getResults().stream().map(gasStationMapper::mapResultDomainToGasStationResponseDTO).collect(Collectors.toList());
    }
}
