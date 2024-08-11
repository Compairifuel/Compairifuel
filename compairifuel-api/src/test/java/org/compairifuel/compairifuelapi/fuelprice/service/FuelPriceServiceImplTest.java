package org.compairifuel.compairifuelapi.fuelprice.service;

import jakarta.ws.rs.NotFoundException;
import org.compairifuel.compairifuelapi.fuelprice.mapper.IFuelPriceMapper;
import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.mockito.Mockito.*;

import static org.junit.jupiter.api.Assertions.*;

class FuelPriceServiceImplTest {
    private final FuelPriceServiceImpl sut = new FuelPriceServiceImpl();
    private IFuelPriceServiceAggregatorAdapter fuelPriceServiceAggregatorAdaptee;


    @BeforeEach
    void setUp() {
        fuelPriceServiceAggregatorAdaptee = mock(IFuelPriceServiceAggregatorAdapter.class);

        sut.setFuelPriceServiceAggregatorAdapter(fuelPriceServiceAggregatorAdaptee);
    }

    @Test
    void getPricesByFuelTypeAndAddressReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO(new PositionDTO(0, 0), "Rijksstraatweg 121C, 3921 AD Elst", 1.4);

        List<FuelPriceResponseDTO> fuelPriceResponseDTOList = List.of(fuelPriceResponseDTO);
        when(fuelPriceServiceAggregatorAdaptee.getPrices(fuelType, address)).thenReturn(fuelPriceResponseDTOList);

        //assert
        assertDoesNotThrow(() -> {
            // Act
            List<FuelPriceResponseDTO> results = sut.getPrices(fuelType, address);
            // Assert
            assertNotNull(results);
            assertInstanceOf(List.class, results);
            assertNotEquals(List.of(), results);
            assertEquals(results.get(0), fuelPriceResponseDTO);
        });
    }

    @Test
    void getPricesByFuelTypeAndAddressThrowsNotFoundException() {
        // Arrange
        String fuelType = "diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        String exceptionMessage = "No fuel prices found for address: " + address;
        when(fuelPriceServiceAggregatorAdaptee.getPrices(fuelType, address)).thenThrow(new NotFoundException(exceptionMessage));

        // Assert
        Exception ex = assertThrows(NotFoundException.class, () -> {
            // Act
            sut.getPrices(fuelType, address);
        });
        assertEquals(exceptionMessage, ex.getMessage());
    }

    @Test
    void getPricesByFuelTypeAndLatitudeAndLongitudeReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        double latitude = 51.987;
        double longitude = 5.922;
        String fuelType = "diesel";
        FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO(new PositionDTO(0, 0), "Rijksstraatweg 121C, 3921 AD Elst", 1.4);

        List<FuelPriceResponseDTO> fuelPriceResponseDTOList = List.of(fuelPriceResponseDTO);
        when(fuelPriceServiceAggregatorAdaptee.getPrices(fuelType, latitude, longitude)).thenReturn(fuelPriceResponseDTOList);

        //assert
        assertDoesNotThrow(() -> {
            // Act
            List<FuelPriceResponseDTO> results = sut.getPrices(fuelType, latitude, longitude);

            // Assert
            assertNotNull(results);
            assertInstanceOf(List.class, results);
            assertNotEquals(List.of(), results);
            assertEquals(results.get(0), fuelPriceResponseDTO);
        });
    }

    @Test
    void getPricesByFuelTypeAndLatitudeAndLongitudeThrowsNotFoundException() {
        // Arrange
        double latitude = 51.987;
        double longitude = 5.922;
        String fueltype = "diesel";
        String exceptionMessage = "No fuel prices found for latitude: " + latitude + " and longitude: " + longitude;
        when(fuelPriceServiceAggregatorAdaptee.getPrices(fueltype,latitude, longitude)).thenThrow(new NotFoundException(exceptionMessage));

        // Assert
        Exception ex = assertThrows(NotFoundException.class, () -> {
            // Act
            sut.getPrices(fueltype, latitude, longitude);
        });
        assertEquals(exceptionMessage, ex.getMessage());
    }

    @Test
    void getPricesByFuelTypeAndAddressAndLatitudeAndLongitudeReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        double latitude = 51.987;
        double longitude = 5.922;
        FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO(new PositionDTO(0, 0), "Rijksstraatweg 121C, 3921 AD Elst", 1.4);

        List<FuelPriceResponseDTO> fuelPriceResponseDTOList = List.of(fuelPriceResponseDTO);
        when(fuelPriceServiceAggregatorAdaptee.getPrices(fuelType, address, latitude, longitude)).thenReturn(fuelPriceResponseDTOList);

        //assert
        assertDoesNotThrow(() -> {
            // Act
            List<FuelPriceResponseDTO> results = sut.getPrices(fuelType, address, latitude, longitude);
            // Assert
            assertNotNull(results);
            assertInstanceOf(List.class, results);
            assertNotEquals(List.of(), results);
            assertEquals(results.get(0), fuelPriceResponseDTO);
        });
    }

    @Test
    void getPricesByFuelTypeAndAddressAndLatitudeAndLongitudeThrowsNotFoundException() {
        // Arrange
        String fuelType = "diesel";
        double latitude = 51.987;
        double longitude = 5.922;
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        String exceptionMessage = "No fuel prices found for latitude and longitude: " + latitude + ", " + longitude;
        when(fuelPriceServiceAggregatorAdaptee.getPrices(fuelType, address,latitude, longitude)).thenThrow(new NotFoundException(exceptionMessage));

        // Assert
        Exception ex = assertThrows(NotFoundException.class, () -> {
            // Act
            sut.getPrices(fuelType, address, latitude, longitude);
        });
        assertEquals(exceptionMessage, ex.getMessage());
    }
}