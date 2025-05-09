package org.compairifuel.compairifuelapi.gasstation.service.domain;

import lombok.Data;

@Data
public class AddressDomain {
    private String streetNumber;
    private String streetName;
    private String municipality;
    private String countrySubdivision;
    private String countrySubdivisionName;
    private String countrySubdivisionCode;
    private String countrySecondarySubdivision;
    private String postalCode;
    private String extendedPostalCode;
    private String countryCode;
    private String country;
    private String countryCodeISO3;
    private String freeformAddress;
    private String localName;
    private String municipalitySubdivision;
    private String neighbourhood;
}
