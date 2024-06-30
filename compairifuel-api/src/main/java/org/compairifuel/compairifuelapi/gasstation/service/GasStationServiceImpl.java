package org.compairifuel.compairifuelapi.gasstation.service;

import jakarta.enterprise.inject.Default;
import lombok.Data;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;

import java.util.List;

@Data
@Default
public class GasStationServiceImpl implements IGasStationService {
    @Override
    public List<GasStationResponseDTO> getGasStations(double latitude, double longitude, int radius) {
        return List.of();
    }
}
