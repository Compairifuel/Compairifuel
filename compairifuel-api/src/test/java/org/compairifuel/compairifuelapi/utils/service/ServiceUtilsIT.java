package org.compairifuel.compairifuelapi.utils.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedHashMap;
import jakarta.ws.rs.core.Response;
import lombok.Cleanup;
import org.compairifuel.compairifuelapi.gasstation.service.GasStationDomain;
import org.compairifuel.compairifuelapi.utils.EnvConfigImpl;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@Tag("integration-test")
public class ServiceUtilsIT {
    private static IEnvConfig envConfig;
    private ServiceUtils serviceUtils;

    @BeforeAll
    public static void setupAll() {
        envConfig = new EnvConfigImpl();
        ((EnvConfigImpl) envConfig).init();
    }

    @BeforeEach
    public void setup() {
        serviceUtils = new ServiceUtils();
    }

    @Test
    public void testSendRequestToTomTomAPI() {
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

        assertDoesNotThrow(() -> {
            GasStationDomain gasStationSearch = serviceUtils.sendRequest(
                    "https://api.tomtom.com/search/2/nearbySearch/.json", queryParams, GasStationDomain.class
            );

            assertNotNull(gasStationSearch);
            assertInstanceOf(GasStationDomain.class, gasStationSearch);
            assertNotNull(gasStationSearch.getSummary());
        });
    }
}
