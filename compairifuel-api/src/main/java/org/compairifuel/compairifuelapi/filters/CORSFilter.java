package org.compairifuel.compairifuelapi.filters;

import jakarta.ws.rs.container.ContainerRequestContext;
import jakarta.ws.rs.container.ContainerResponseContext;
import jakarta.ws.rs.container.ContainerResponseFilter;
import jakarta.ws.rs.ext.Provider;

@Provider
public class CORSFilter implements ContainerResponseFilter {
	@Override
	public void filter(final ContainerRequestContext
		                   requestContext,final ContainerResponseContext cres) {
		cres.getHeaders().add("Access-Control-Allow-Origin", "*");
	}
}
