package org.compairifuel.compairifuelapi.fuelprice.service;

import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;

import java.io.IOException;
import java.util.List;

public interface IFuelPriceServiceAggregatorAdapter {
    List<FuelPriceResponseDTO> getPrices(String fuelType, String address) throws IOException;
}
