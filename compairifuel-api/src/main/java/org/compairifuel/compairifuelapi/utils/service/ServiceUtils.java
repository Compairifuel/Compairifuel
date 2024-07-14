package org.compairifuel.compairifuelapi.utils.service;

import jakarta.enterprise.inject.Default;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedHashMap;
import jakarta.ws.rs.core.Response;
import lombok.Cleanup;

import java.util.logging.Logger;

public class ServiceUtils {
    private final Logger logger = Logger.getLogger(this.getClass().getName());

    public <T> T sendRequest(String url, MultivaluedHashMap<String, Object> queryParams, Class<T> cls) {
        @Cleanup Client client = ClientBuilder.newClient();
        WebTarget target = client.target(url);

        MultivaluedHashMap<String, Object> headers = new MultivaluedHashMap<>();
        headers.add("Content-Type", "application/json");
        headers.add("Accept", "*/*");

        for (String key : queryParams.keySet()) {
            target = target.queryParam(key, queryParams.get(key).toArray());
        }

        @Cleanup Response response = target.request(MediaType.APPLICATION_JSON).headers(headers).get(Response.class);
        if(response.getStatus() != 200) {
            logger.severe("Failed to get gas stations from TomTom API. Status code: " + response.getStatus());
            throw new RuntimeException("Failed to get gas stations from TomTom API. Status code: " + response.getStatus());
        }

        /*
         * Probleem: Methode returned een Response die al gesloten is
         * Oplossing: Verplaats de readEntity naar de serviceUtils.
         * Alternatieven: De client buiten ServiceUtils aanmaken.
         * Reden: Deze oplossing zorgt ervoor dat de verantwoordelijkheid van de client bij de serviceUtils blijft.
         */
        return response.readEntity(cls);
    }
}
