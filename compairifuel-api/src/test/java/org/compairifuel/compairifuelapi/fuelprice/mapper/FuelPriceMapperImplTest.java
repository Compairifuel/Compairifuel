package org.compairifuel.compairifuelapi.fuelprice.mapper;

import jakarta.ws.rs.InternalServerErrorException;
import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class FuelPriceMapperImplTest {
    private final FuelPriceMapperImpl sut = new FuelPriceMapperImpl();
    private final FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO();
    private final List<String> fuelPriceCSVRowThrowsInternalServerErrorException = List.of();
    private final List<String> fuelPriceCSVRowReturnsCorrectly = new ArrayList<>();

    @BeforeEach
    void setUp() {
        fuelPriceResponseDTO.setPosition(new PositionDTO(51.9834048,5.4997363));
        fuelPriceResponseDTO.setPrice(1.995);
        fuelPriceResponseDTO.setAddress("Rijksstraatweg 121C, 3921 AD Elst");

        fuelPriceCSVRowReturnsCorrectly.add("Rijksstraatweg 121C, 3921 AD Elst");
        fuelPriceCSVRowReturnsCorrectly.add("1.995");
        fuelPriceCSVRowReturnsCorrectly.add("51.9834048");
        fuelPriceCSVRowReturnsCorrectly.add("5.4997363");
        fuelPriceCSVRowReturnsCorrectly.add("Diesel");
    }

    @Test
    void mappingFuelPriceCSVRowToFuelPriceResponseDTOReturnsCorrectly() {
        // Assert
        assertDoesNotThrow(() -> {
            // Act
            FuelPriceResponseDTO result = sut.mapFuelPriceCSVRowToFuelPriceResponseDTO(fuelPriceCSVRowReturnsCorrectly);

            // Assert
            assertNotNull(result);
            assertEquals(result,fuelPriceResponseDTO);
        });
    }

    @Test
    void mappingFuelPriceCSVRowToFuelPriceResponseDTOThrowsInternalServerErrorException() {
        // Assert
        assertThrows(InternalServerErrorException.class, () -> sut.mapFuelPriceCSVRowToFuelPriceResponseDTO(fuelPriceCSVRowThrowsInternalServerErrorException));
    }
}
