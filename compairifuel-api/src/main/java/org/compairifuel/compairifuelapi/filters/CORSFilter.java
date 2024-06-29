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
//		cres.getHeaders().add("Access-Control-Allow-Headers", "origin, content-type, accept, authorization");
//		cres.getHeaders().add("Access-Control-Allow-Credentials", "true");
//		cres.getHeaders().add("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD");
//		cres.getHeaders().add("Access-Control-Max-Age", "1209600");
	}
}
