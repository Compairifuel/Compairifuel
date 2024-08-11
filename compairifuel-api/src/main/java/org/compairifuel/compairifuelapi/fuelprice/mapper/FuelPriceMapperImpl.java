package org.compairifuel.compairifuelapi.fuelprice.mapper;

import jakarta.enterprise.inject.Default;
import jakarta.ws.rs.InternalServerErrorException;
import lombok.extern.java.Log;
import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;
import org.compairifuel.compairifuelapi.fuelprice.service.FuelPriceDomain;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;

import java.util.List;

@Log(topic = "FuelPriceMapperImpl")
@Default
public class FuelPriceMapperImpl implements IFuelPriceMapper {
    @Override
    public FuelPriceResponseDTO mapFuelPriceCSVRowToFuelPriceResponseDTO(List<String> column) {
        try {
            FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO();
            fuelPriceResponseDTO.setPrice(Double.parseDouble(column.get(1)));
            fuelPriceResponseDTO.setAddress(column.get(0));
            fuelPriceResponseDTO.setPosition(new PositionDTO(Double.parseDouble(column.get(2)), Double.parseDouble(column.get(3))));
            return fuelPriceResponseDTO;
        } catch (Exception e) {
            log.severe("Something went wrong: " + e.getMessage());
            throw new InternalServerErrorException();
        }
    }
}
