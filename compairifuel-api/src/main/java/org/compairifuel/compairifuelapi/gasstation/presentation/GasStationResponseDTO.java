package org.compairifuel.compairifuelapi.gasstation.presentation;

import lombok.Data;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;

import java.util.List;

@Data
public class GasStationResponseDTO {
    private PositionDTO position;
    private String name;
    private String id;
    private String address;
    private List<PositionDTO> entryPoints;
    private List<PositionDTO> viewport;
}