package org.compairifuel.compairifuelapi.fuelprice.service;

import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;

import java.util.List;

public interface IFuelPriceService {
    List<FuelPriceResponseDTO> getPrices(String fuelType, String address);
    List<FuelPriceResponseDTO> getPrices(String fuelType, double latitude, double longitude);
    List<FuelPriceResponseDTO> getPrices(String fuelType, String address, double latitude, double longitude);
}