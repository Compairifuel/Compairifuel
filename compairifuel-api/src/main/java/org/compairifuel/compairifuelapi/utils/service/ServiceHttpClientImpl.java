package org.compairifuel.compairifuelapi.utils.service;

import jakarta.enterprise.inject.Default;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedHashMap;
import jakarta.ws.rs.core.Response;
import lombok.Cleanup;
import lombok.extern.java.Log;

@Log(topic = "ServiceHttpClientImpl")
@Default
public class ServiceHttpClientImpl implements IServiceHttpClient {

    /**
    * Sends a request to the given url with the given query parameters.
    *
    * @param url: The url to send the request to.
    * @param queryParams: The query parameters to send with the request.
    * @param cls: The class to map the response to.
    * @return T: The response mapped to the class.
    * @throws RuntimeException: When the response status is not 200.
     **/
    @Override
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
            log.severe("Failed to get gas stations from TomTom API. Status code: " + response.getStatus());
            throw new RuntimeException("Failed to get gas stations from TomTom API. Status code: " + response.getStatus());
        }

        /*
        * Problem: Method returns a Response that is already closed
        * Solution: Move the readEntity to the ServiceUtils.
        * Alternatives: Create the client outside ServiceUtils.
        * Reason: This solution ensures that the responsibility for the client remains within ServiceUtils.
        */
        return response.readEntity(cls);
    }
}
