package org.compairifuel.compairifuelapi.gasstation.service;

import jakarta.enterprise.inject.Default;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;

import java.util.List;

@Default
public class GasStationServiceImpl implements IGasStationService {
    @Override
    public List<GasStationResponseDTO> getGasStations(double latitude, double longitude, int radius) {
        return List.of();
    }
}
