package org.compairifuel.compairifuelapi.fuelprice.service;

import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;

import java.io.IOException;
import java.util.List;

public interface IFuelPriceServiceAggregatorAdapter {
    List<FuelPriceResponseDTO> getPrices(String fuelType, String address) throws IOException;
}
