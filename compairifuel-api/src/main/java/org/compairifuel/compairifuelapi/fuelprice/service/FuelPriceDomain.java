package org.compairifuel.compairifuelapi.fuelprice.service;

import lombok.Data;

import java.util.List;

@Data
public class FuelPriceDomain {
    private List<FuelDomain> fuels;
    private String fuelPrice;
}
