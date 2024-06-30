package org.compairifuel.compairifuelapi.fuelprice.presentation;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;

@AllArgsConstructor
@Data
public class FuelPriceResponseDTO {
    private PositionDTO position;
    private String address;
    private double price;
}
