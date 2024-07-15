package org.compairifuel.compairifuelapi.utils.service;

import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedHashMap;
import jakarta.ws.rs.core.Response;
import lombok.Cleanup;

import java.util.logging.Logger;

public interface IServiceHttpClient {
    public <T> T sendRequest(String url, MultivaluedHashMap<String, Object> queryParams, Class<T> cls);
}
