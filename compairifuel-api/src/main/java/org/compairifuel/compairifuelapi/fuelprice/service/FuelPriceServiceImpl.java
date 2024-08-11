package org.compairifuel.compairifuelapi.fuelprice.service;

import jakarta.enterprise.inject.Default;
import jakarta.inject.Inject;
import lombok.extern.java.Log;
import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;
import java.util.List;

@Log(topic = "FuelPriceServiceImpl")
@Default
public class FuelPriceServiceImpl implements IFuelPriceService {
    private IFuelPriceServiceAggregatorAdapter fuelPriceServiceAggregatorAdapter;

    @Inject
    public void setFuelPriceServiceAggregatorAdapter(IFuelPriceServiceAggregatorAdapter fuelPriceServiceAggregatorAdapter) {
        this.fuelPriceServiceAggregatorAdapter = fuelPriceServiceAggregatorAdapter;
    }

    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address) {
        return fuelPriceServiceAggregatorAdapter.getPrices(fuelType, address);
    }

    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, double latitude, double longitude) {
        return fuelPriceServiceAggregatorAdapter.getPrices(fuelType, latitude, longitude);
    }

    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address, double latitude, double longitude) {
        return fuelPriceServiceAggregatorAdapter.getPrices(fuelType, address, latitude, longitude);
    }
}