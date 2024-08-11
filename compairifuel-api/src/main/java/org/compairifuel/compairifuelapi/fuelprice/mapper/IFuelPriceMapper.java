package org.compairifuel.compairifuelapi.fuelprice.mapper;

import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;
import org.compairifuel.compairifuelapi.fuelprice.service.FuelPriceDomain;

import java.util.List;

public interface IFuelPriceMapper {
    FuelPriceResponseDTO mapFuelPriceCSVRowToFuelPriceResponseDTO(List<String> row);

}
