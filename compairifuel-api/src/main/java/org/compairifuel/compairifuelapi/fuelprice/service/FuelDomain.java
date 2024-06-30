package org.compairifuel.compairifuelapi.fuelprice.service;

import lombok.Data;

import java.util.List;

@Data
public class FuelDomain {
    private String type;
    private List<PriceDomain> price;
    private String updatedAt;
}
