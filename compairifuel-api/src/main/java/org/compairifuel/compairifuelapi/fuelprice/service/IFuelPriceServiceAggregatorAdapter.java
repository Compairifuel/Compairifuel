package org.compairifuel.compairifuelapi.fuelprice.service;

import jakarta.ws.rs.NotFoundException;
import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;

import java.util.List;

public interface IFuelPriceServiceAggregatorAdapter {
    List<FuelPriceResponseDTO> getPrices(String fuelType, String address) throws NotFoundException;
    List<FuelPriceResponseDTO> getPrices(String fuelType, double latitude, double longitude) throws NotFoundException;
    List<FuelPriceResponseDTO> getPrices(String fuelType, String address, double latitude, double longitude) throws NotFoundException;
}
