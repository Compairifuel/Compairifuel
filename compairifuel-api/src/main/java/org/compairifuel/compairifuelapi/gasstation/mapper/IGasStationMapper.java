package org.compairifuel.compairifuelapi.gasstation.mapper;

import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.service.domain.ResultDomain;

public interface IGasStationMapper {
    GasStationResponseDTO mapResultDomainToGasStationResponseDTO(ResultDomain resultDomain);
}
