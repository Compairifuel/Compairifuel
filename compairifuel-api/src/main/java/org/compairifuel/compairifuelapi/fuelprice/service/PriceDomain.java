package org.compairifuel.compairifuelapi.fuelprice.service;

import lombok.Data;

@Data
public class PriceDomain {
    private double value;
    private String currency;
    private String currencySymbol;
    private String volumeUnit;
}
