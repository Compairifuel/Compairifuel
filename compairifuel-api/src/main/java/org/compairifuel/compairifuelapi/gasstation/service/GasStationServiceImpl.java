package org.compairifuel.compairifuelapi.gasstation.service;

import jakarta.enterprise.inject.Default;
import jakarta.inject.Inject;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedHashMap;
import jakarta.ws.rs.core.Response;
import lombok.Cleanup;
import lombok.Data;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;

import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@Data
@Default
public class GasStationServiceImpl implements IGasStationService {
    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private IEnvConfig envConfig;

    @Inject
    public void setEnvConfig(IEnvConfig envConfig) {
        this.envConfig = envConfig;
    }

    @Override
    public List<GasStationResponseDTO> getGasStations(double latitude, double longitude, int radius) {
        String apiKey = envConfig.getEnv("API_KEY");

        @Cleanup Client client = ClientBuilder.newClient();
        MultivaluedHashMap<String, Object> headers = new MultivaluedHashMap<>();
        headers.add("Content-Type", "application/json");
        headers.add("Accept", "*/*");
        WebTarget target = client.target("https://api.tomtom.com/search/2/nearbySearch/.json")
                .queryParam("key", apiKey)
                .queryParam("lat", latitude)
                .queryParam("lon", longitude)
                .queryParam("radius", radius)
                .queryParam("categorySet", 7311)
                .queryParam("relatedPois", "off")
                .queryParam("limit", 100)
                .queryParam("countrySet", "NLD,BEL,DEU")
                .queryParam("minFuzzyLevel", 2)
                .queryParam("maxFuzzyLevel", 4);
        @Cleanup Response response = target.request(MediaType.APPLICATION_JSON).headers(headers).get(Response.class);
        if(response.getStatus() != 200) {
            logger.severe("Failed to get gas stations from TomTom API. Status code: " + response.getStatus());
            throw new RuntimeException("Failed to get gas stations from TomTom API. Status code: " + response.getStatus());
        }
        GasStationDomain gasStationSearch = response.readEntity(GasStationDomain.class);

        // https://api.tomtom.com/search/2/nearbySearch/.json?key=TTkngWVhaw2tDzCPcd7EUMx7WAkY6I8x&lat=0&lon=0&radius=20&categorySet=7311&relatedPois=off&limit=100&countrySet=NLD,BEL,DEU&minFuzzyLevel=2&maxFuzzyLevel=4

        return gasStationSearch.getResults().stream().map(this::mapToGasStationResponseDTO).collect(Collectors.toList());
    }

    private GasStationResponseDTO mapToGasStationResponseDTO(ResultDomain resultDomain) {
        GasStationResponseDTO gasStationResponseDTO = new GasStationResponseDTO();
        gasStationResponseDTO.setId(resultDomain.getId());
        gasStationResponseDTO.setName(resultDomain.getPoi().getName());
        gasStationResponseDTO.setAddress(resultDomain.getAddress().getFreeformAddress());
        gasStationResponseDTO.setPosition(new PositionDTO(resultDomain.getPosition().getLat(), resultDomain.getPosition().getLon()));
        gasStationResponseDTO.setEntryPoints(resultDomain.getEntryPoints().stream().map(entryPoint -> new PositionDTO(entryPoint.getPosition().getLat(), entryPoint.getPosition().getLon())).collect(Collectors.toList()));
        gasStationResponseDTO.setViewport(
                List.of(new PositionDTO(resultDomain.getViewport().getTopLeftPoint().getLat(), resultDomain.getViewport().getTopLeftPoint().getLon()),
                        new PositionDTO(resultDomain.getViewport().getBtmRightPoint().getLat(), resultDomain.getViewport().getBtmRightPoint().getLon())
                )
        );
        return gasStationResponseDTO;
    }
}