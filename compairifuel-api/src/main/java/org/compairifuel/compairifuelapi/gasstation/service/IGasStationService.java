package org.compairifuel.compairifuelapi.gasstation.service;

import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;

import java.util.List;

public interface IGasStationService {
    List<GasStationResponseDTO> getGasStations(double latitude, double longitude, int radius);
}
