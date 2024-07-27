package org.compairifuel.compairifuelapi.fuelprice.service;

import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;

import java.io.IOException;
import java.util.List;

public interface IFuelPriceServiceAggregatorAdapter {
    List<FuelPriceResponseDTO> getPrices(String fuelType, String address) throws IOException;
    List<FuelPriceResponseDTO> getPrices(String fuelType, double latitude, double longitude) throws IOException;
    List<FuelPriceResponseDTO> getPrices(String fuelType, String address, double latitude, double longitude) throws IOException;
}
