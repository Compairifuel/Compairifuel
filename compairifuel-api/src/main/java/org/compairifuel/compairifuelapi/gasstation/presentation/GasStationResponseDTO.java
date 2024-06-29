package org.compairifuel.compairifuelapi.gasstation.presentation;

import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;

import java.util.List;

public class GasStationResponseDTO {
    private PositionDTO position;
    private String name;
    private int id;
    private String address;
    private List<PositionDTO> entryPoints;
    private List<PositionDTO> viewport;
}
