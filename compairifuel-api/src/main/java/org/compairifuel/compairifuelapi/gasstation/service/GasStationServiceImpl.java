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
import org.compairifuel.compairifuelapi.utils.service.ServiceUtils;

import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@Data
@Default
public class GasStationServiceImpl implements IGasStationService {
    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private IEnvConfig envConfig;
    private ServiceUtils serviceUtils;

    @Inject
    public void setEnvConfig(IEnvConfig envConfig) {
        this.envConfig = envConfig;
    }

    @Inject
    public void setServiceUtils(ServiceUtils serviceUtils) {
        this.serviceUtils = serviceUtils;
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

        GasStationDomain gasStationSearch = serviceUtils.sendRequest(
                "https://api.tomtom.com/search/2/nearbySearch/.json", queryParams, GasStationDomain.class
        );

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