package org.compairifuel.compairifuelapi.utils.service;

import jakarta.ws.rs.core.MultivaluedHashMap;
import org.compairifuel.compairifuelapi.gasstation.service.domain.GasStationDomain;
import org.compairifuel.compairifuelapi.utils.EnvConfigImpl;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@Tag("integration-test")
public class IServiceHttpClientIT {
    private static IEnvConfig envConfig;
    private IServiceHttpClient serviceHttpClient;

    @BeforeAll
    public static void setupAll() {
        envConfig = new EnvConfigImpl();
        ((EnvConfigImpl) envConfig).init();
    }

    @BeforeEach
    public void setup() {
        serviceHttpClient = new ServiceHttpClientImpl();
    }

    @Test
    public void testSendRequestToTomTomAPI() {
        // Arrange
        String apiKey = envConfig.getEnv("API_KEY");

        MultivaluedHashMap<String, Object> queryParams = new MultivaluedHashMap<>();
        queryParams.add("key", apiKey);
        queryParams.add("lat", 52.0038789);
        queryParams.add("lon", 5.9269373);
        queryParams.add("radius", 25000);
        queryParams.add("categorySet", 7311);
        queryParams.add("relatedPois", "off");
        queryParams.add("limit", 100);
        queryParams.add("countrySet", "NLD,BEL,DEU");
        queryParams.add("minFuzzyLevel", 2);
        queryParams.add("maxFuzzyLevel", 4);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            GasStationDomain gasStationSearch = serviceHttpClient.sendRequest(
                    "https://api.tomtom.com/search/2/nearbySearch/.json", queryParams, GasStationDomain.class
            );

            // Assert
            assertNotNull(gasStationSearch);
            assertInstanceOf(GasStationDomain.class, gasStationSearch);
            assertNotNull(gasStationSearch.getSummary());
        });
    }
}
