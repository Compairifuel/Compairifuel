package org.compairifuel.compairifuelapi.exceptions.mappers;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.ext.ExceptionMapper;

import java.util.ArrayList;
import java.util.List;

public class ConstraintViolationExceptionMapper implements ExceptionMapper<ConstraintViolationException> {
    /**
     * Maps the ConstraintViolation thrown for a Jakarta Validation (JSR 380)
     * The Jakarta Validation (JSR 380) is added to request POJO's requiring validation.
     *
     * @param exception the thrown exception
     * @return response to the client
     */
    @Override
    public Response toResponse(final ConstraintViolationException exception) {

        List<ConstraintViolation<?>> constraints = new ArrayList<>(exception.getConstraintViolations());

        String constraintMessage = constraints
                .stream()
                .map(ConstraintViolation::getMessage)
                .reduce("", (a, b) -> a + b + "\n");

        return Response.status(Response.Status.BAD_REQUEST).entity(constraintMessage).build();
    }
}
