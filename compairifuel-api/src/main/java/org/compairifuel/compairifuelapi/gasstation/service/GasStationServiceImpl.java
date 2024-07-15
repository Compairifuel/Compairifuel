package org.compairifuel.compairifuelapi.gasstation.service;

import jakarta.enterprise.inject.Default;
import jakarta.inject.Inject;
import lombok.Data;
import lombok.extern.java.Log;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;
import org.compairifuel.compairifuelapi.utils.IEnvConfig;

import java.util.List;

@Log(topic = "GasStationServiceImpl")
@Data
@Default
public class GasStationServiceImpl implements IGasStationService {
    private IGasStationsServiceAggregatorAdapter gasStationsServiceAggregatorAdapter;

    @Inject
    public void setTomTomGasStationServiceAdaptee(IGasStationsServiceAggregatorAdapter gasStationsServiceAggregatorAdapter) {
        this.gasStationsServiceAggregatorAdapter = gasStationsServiceAggregatorAdapter;
    }

    @SuppressWarnings("UnnecessaryLocalVariable")
    @Override
    public List<GasStationResponseDTO> getGasStations(double latitude, double longitude, int radius) {
        List<GasStationResponseDTO> result = gasStationsServiceAggregatorAdapter.getGasStations(latitude, longitude, radius);
        return result;
    }
}