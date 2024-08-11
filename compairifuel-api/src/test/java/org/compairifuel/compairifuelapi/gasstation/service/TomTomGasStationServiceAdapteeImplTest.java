package org.compairifuel.compairifuelapi.gasstation.service;

import jakarta.ws.rs.NotFoundException;
import jakarta.ws.rs.core.MultivaluedHashMap;
import org.compairifuel.compairifuelapi.fuelprice.mapper.IFuelPriceMapper;
import org.compairifuel.compairifuelapi.gasstation.mapper.IGasStationMapper;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.service.domain.*;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;
import org.compairifuel.compairifuelapi.utils.service.IServiceHttpClient;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class TomTomGasStationServiceAdapteeImplTest {
    private final TomTomGasStationServiceAdapteeImpl sut = new TomTomGasStationServiceAdapteeImpl();
    private IServiceHttpClient serviceHttpClient;
    private IEnvConfig envConfig;
    private final String API_KEY = "apiKey";
    private IGasStationMapper gasStationMapper;

    @BeforeEach
    void setUp() {
        serviceHttpClient = mock(IServiceHttpClient.class);
        envConfig = mock(IEnvConfig.class);
        gasStationMapper = mock(IGasStationMapper.class);

        sut.setGasStationMapper(gasStationMapper);
        sut.setServiceHttpClient(serviceHttpClient);
        sut.setEnvConfig(envConfig);

        when(envConfig.getEnv("API_KEY")).thenReturn(API_KEY);
    }

    @Test
    void getGasStationsReturnsListOfGasStationResponseDTO() {
        // Arrange
        double latitude = 10;
        double longitude = 455;
        int radius = 25000;

        MultivaluedHashMap<String, Object> queryParams = new MultivaluedHashMap<>();
        queryParams.add("key", API_KEY);
        queryParams.add("lat", latitude);
        queryParams.add("lon", longitude);
        queryParams.add("radius", radius);
        queryParams.add("categorySet", 7311);
        queryParams.add("relatedPois", "off");
        queryParams.add("limit", 100);
        queryParams.add("countrySet", "NLD,BEL,DEU");
        queryParams.add("minFuzzyLevel", 2);
        queryParams.add("maxFuzzyLevel", 4);

        GasStationDomain gasStationDomain = new GasStationDomain();
        gasStationDomain.setResults(List.of());
        when(serviceHttpClient.sendRequest("https://api.tomtom.com/search/2/nearbySearch/.json", queryParams, GasStationDomain.class))
                .thenReturn(gasStationDomain);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            List<GasStationResponseDTO> results = sut.getGasStations(latitude, longitude, radius);

            // Assert
            assertNotNull(results);
            assertInstanceOf(List.class, results);

        });
    }

    @Test
    void getGasStationsThrowsRunTimeException() {
        // Arrange
        double latitude = 10;
        double longitude = 455;
        int radius = 25000;
        when(serviceHttpClient.sendRequest("",new MultivaluedHashMap<>(),GasStationResponseDTO.class)).thenThrow(new RuntimeException());

        // Assert
        assertThrows(RuntimeException.class, () -> {
            // Act
            sut.getGasStations(latitude, longitude, radius);
        });
    }
}