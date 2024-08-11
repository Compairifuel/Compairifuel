package org.compairifuel.compairifuelapi.gasstation.mapper;

import jakarta.enterprise.inject.Default;
import jakarta.ws.rs.InternalServerErrorException;
import lombok.extern.java.Log;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.service.domain.ResultDomain;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;

import java.util.List;
import java.util.stream.Collectors;

@Log(topic = "GasStationMapperImpl")
@Default
public class GasStationMapperImpl implements IGasStationMapper {
    @Override
    public GasStationResponseDTO mapResultDomainToGasStationResponseDTO(ResultDomain resultDomain) throws InternalServerErrorException {
        try {
            GasStationResponseDTO gasStationResponseDTO = new GasStationResponseDTO();
            gasStationResponseDTO.setId(resultDomain.getId());
            gasStationResponseDTO.setAddress(resultDomain.getAddress().getFreeformAddress());
            gasStationResponseDTO.setName(resultDomain.getPoi().getName());
            gasStationResponseDTO.setPosition(new PositionDTO(resultDomain.getPosition().getLat(), resultDomain.getPosition().getLon()));

            gasStationResponseDTO.setEntryPoints(resultDomain.getEntryPoints().stream().map(e -> new PositionDTO(e.getPosition().getLat(), e.getPosition().getLon())).collect(Collectors.toList()));

            gasStationResponseDTO.setViewport(List.of(
                    new PositionDTO(resultDomain.getViewport().getTopLeftPoint().getLat(), resultDomain.getViewport().getTopLeftPoint().getLon()),
                    new PositionDTO(resultDomain.getViewport().getBtmRightPoint().getLat(), resultDomain.getViewport().getBtmRightPoint().getLon())));
            return gasStationResponseDTO;
        } catch (Exception e) {
            log.severe("Something went wrong: " + e.getMessage());
            throw new InternalServerErrorException();
        }
    }
}
