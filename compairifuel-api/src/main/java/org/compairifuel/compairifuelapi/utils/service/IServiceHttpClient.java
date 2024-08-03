package org.compairifuel.compairifuelapi.utils.service;

import jakarta.ws.rs.core.MultivaluedHashMap;

public interface IServiceHttpClient {
    public <T> T sendRequest(String url, MultivaluedHashMap<String, Object> queryParams, Class<T> cls);
}
