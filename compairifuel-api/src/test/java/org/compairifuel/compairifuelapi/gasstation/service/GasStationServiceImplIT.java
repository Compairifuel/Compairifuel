package org.compairifuel.compairifuelapi.gasstation.service;

import jakarta.ws.rs.core.MultivaluedHashMap;
import org.compairifuel.compairifuelapi.gasstation.mapper.IGasStationMapper;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.service.domain.GasStationDomain;
import org.compairifuel.compairifuelapi.gasstation.service.domain.ResultDomain;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;
import org.compairifuel.compairifuelapi.utils.service.IServiceHttpClient;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@Tag("integration-test")
class GasStationServiceImplIT {
    private final GasStationServiceImpl sut = new GasStationServiceImpl();
    private TomTomGasStationServiceAdapteeImpl gasStationsServiceAggregatorAdapter;
    private IServiceHttpClient serviceHttpClient;
    private IEnvConfig envConfig;
    private IGasStationMapper gasStationMapper;
    private final String apiKey = "apikey";

    @BeforeEach
    void setUp() {
        serviceHttpClient = mock(IServiceHttpClient.class);
        envConfig = mock(IEnvConfig.class);
        gasStationMapper = mock(IGasStationMapper.class);
        gasStationsServiceAggregatorAdapter = new TomTomGasStationServiceAdapteeImpl();
        gasStationsServiceAggregatorAdapter.setServiceHttpClient(serviceHttpClient);
        gasStationsServiceAggregatorAdapter.setEnvConfig(envConfig);
        gasStationsServiceAggregatorAdapter.setGasStationMapper(gasStationMapper);
        sut.setGasStationsServiceAggregatorAdapter(gasStationsServiceAggregatorAdapter);
    }

    @Test
    void getGasStationsCallsCorrectMethods() {
        // Arrange
        double latitude = 52.0038789;
        double longitude = 5.9269373;
        int radius = 25000;

        when(envConfig.getEnv("API_KEY")).thenReturn(apiKey);

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

        ResultDomain resultDomain = new ResultDomain();

        GasStationDomain gasStationDomain = new GasStationDomain();
        gasStationDomain.setResults(List.of(resultDomain));

        when(serviceHttpClient.sendRequest(
            "https://api.tomtom.com/search/2/nearbySearch/.json", queryParams, GasStationDomain.class
        )).thenReturn(gasStationDomain);

        // Act
        sut.getGasStations(latitude, longitude, radius);

        // Assert
        verify(envConfig).getEnv("API_KEY");
        verify(serviceHttpClient).sendRequest(
            "https://api.tomtom.com/search/2/nearbySearch/.json", queryParams, GasStationDomain.class
        );
        verify(gasStationMapper).mapResultDomainToGasStationResponseDTO(resultDomain);
    }

    @Test
    void getGasStationsReturnsListOfGasStationResponseDTO() {
        // Arrange
        double latitude = 52.0038789;
        double longitude = 5.9269373;
        int radius = 25000;

        when(envConfig.getEnv("API_KEY")).thenReturn(apiKey);

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

        ResultDomain resultDomain = new ResultDomain();

        GasStationDomain gasStationDomain = new GasStationDomain();
        gasStationDomain.setResults(List.of(resultDomain));

        GasStationResponseDTO responseDTO = new GasStationResponseDTO();

        when(serviceHttpClient.sendRequest(
            "https://api.tomtom.com/search/2/nearbySearch/.json", queryParams, GasStationDomain.class
        )).thenReturn(gasStationDomain);
        
        when(gasStationMapper.mapResultDomainToGasStationResponseDTO(resultDomain)).thenReturn(responseDTO);

        // Act
        List<GasStationResponseDTO> results = sut.getGasStations(latitude, longitude, radius);

        // Assert
        assertNotNull(results);
        assertInstanceOf(List.class, results);
        assertEquals(1, results.size());
        assertEquals(responseDTO, results.get(0));
    }

    @Test
    void getGasStationsThrowsServiceHttpClientRuntimeException() {
        // Arrange
        double latitude = 52.0038789;
        double longitude = 5.9269373;
        int radius = 25000;

        when(envConfig.getEnv("API_KEY")).thenReturn(apiKey);

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

        ResultDomain resultDomain = new ResultDomain();

        GasStationDomain gasStationDomain = new GasStationDomain();
        gasStationDomain.setResults(List.of(resultDomain));

        GasStationResponseDTO responseDTO = new GasStationResponseDTO();

        when(serviceHttpClient.sendRequest(
            "https://api.tomtom.com/search/2/nearbySearch/.json", queryParams, GasStationDomain.class
        )).thenThrow(new RuntimeException());

        when(gasStationMapper.mapResultDomainToGasStationResponseDTO(resultDomain)).thenReturn(responseDTO);

        // Assert
        assertThrows(RuntimeException.class, () -> {
            // Act
            sut.getGasStations(latitude, longitude, radius);
        });
    }
}