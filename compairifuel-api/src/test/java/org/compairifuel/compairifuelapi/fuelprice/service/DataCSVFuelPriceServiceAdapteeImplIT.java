package org.compairifuel.compairifuelapi.fuelprice.service;

import jakarta.ws.rs.NotFoundException;
import org.compairifuel.compairifuelapi.fuelprice.mapper.IFuelPriceMapper;
import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@Tag("integration-test")
class DataCSVFuelPriceServiceAdapteeImplIT {
    private final DataCSVFuelPriceServiceAdapteeImpl sut = new DataCSVFuelPriceServiceAdapteeImpl();
    private IFuelPriceMapper fuelPriceMapper;

    @BeforeEach
    void setUp() {
        fuelPriceMapper = mock(IFuelPriceMapper.class);

        sut.setFuelPriceMapper(fuelPriceMapper);
    }

    @Test
    void getPricesByFuelTypeAndAddressReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "Diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO(new PositionDTO(51.9834048, 5.4997363), "Rijksstraatweg 121C, 3921 AD Elst", 1.995);
        when(fuelPriceMapper.mapFuelPriceCSVRowToFuelPriceResponseDTO(anyList())).thenReturn(fuelPriceResponseDTO);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            List<FuelPriceResponseDTO> result = sut.getPrices(fuelType, address);

            // Assert
            assertNotNull(result);
            assertFalse(result.isEmpty());
            assertEquals(result.get(0), fuelPriceResponseDTO);
        });
    }

    @Test
    void getPricesByFuelTypeAndAddressThrowsNotFoundException() {
        // Arrange
        String fuelType = "";
        String address = "";
        String exceptionMessage = "No fuel prices found for address: " + address;

        // Assert
        Exception ex = assertThrows(NotFoundException.class, () -> {
            // Act
            sut.getPrices(fuelType, address);
        });

        // Assert
        assertNotNull(ex);
        assertEquals(exceptionMessage, ex.getMessage());
    }

    @Test
    void getPricesByFuelTypeAndLatitudeAndLongitudeReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "Diesel";
        double latitude = 51.9834048;
        double longitude = 5.4997363;
        FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO(new PositionDTO(51.9834048, 5.4997363), "Rijksstraatweg 121C, 3921 AD Elst", 1.995);
        when(fuelPriceMapper.mapFuelPriceCSVRowToFuelPriceResponseDTO(anyList())).thenReturn(fuelPriceResponseDTO);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            List<FuelPriceResponseDTO> result = sut.getPrices(fuelType, latitude, longitude);

            // Assert
            assertNotNull(result);
            assertFalse(result.isEmpty());
            assertEquals(result.get(0), fuelPriceResponseDTO);
        });
    }

    @Test
    void getPricesByFuelTypeAndLatitudeAndLongitudeWithLeewayReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "Diesel";
        double latitudeLeeway = 51.9834048 + 0.00005;
        double longitudeLeeway = 5.4997363 - 0.00005;
        FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO(new PositionDTO(51.9834048, 5.4997363), "Rijksstraatweg 121C, 3921 AD Elst", 1.995);
        when(fuelPriceMapper.mapFuelPriceCSVRowToFuelPriceResponseDTO(anyList())).thenReturn(fuelPriceResponseDTO);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            List<FuelPriceResponseDTO> result = sut.getPrices(fuelType, latitudeLeeway, longitudeLeeway);

            // Assert
            assertNotNull(result);
            assertFalse(result.isEmpty());
            assertEquals(result.get(0), fuelPriceResponseDTO);
        });
    }

    @Test
    void getPricesByFuelTypeAndLatitudeAndLongitudeThrowsNotFoundException() {
        // Arrange
        String fuelType = "";
        double latitude = 0;
        double longitude = 0;
        String exceptionMessage = "No fuel prices found for latitude and longitude: " + latitude + ", " + longitude;

        // Assert
        Exception ex = assertThrows(NotFoundException.class, () -> {
            // Act
            sut.getPrices(fuelType, latitude, longitude);
        });

        // Assert
        assertNotNull(ex);
        assertEquals(exceptionMessage, ex.getMessage());
    }

    @Test
    void getPricesByFuelTypeAddressAndLatitudeAndLongitudeReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "Diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        double latitude = 51.9834048;
        double longitude = 5.4997363;
        FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO(new PositionDTO(51.9834048, 5.4997363), "Rijksstraatweg 121C, 3921 AD Elst", 1.995);
        when(fuelPriceMapper.mapFuelPriceCSVRowToFuelPriceResponseDTO(anyList())).thenReturn(fuelPriceResponseDTO);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            List<FuelPriceResponseDTO> result = sut.getPrices(fuelType, address, latitude, longitude);

            // Assert
            assertNotNull(result);
            assertFalse(result.isEmpty());
            assertEquals(result.get(0), fuelPriceResponseDTO);
        });
    }

    @Test
    void getPricesByFuelTypeAddressAndLatitudeAndLongitudeThrowsNotFoundException() {
        // Arrange
        String fuelType = "";
        String address = "";
        double latitude = 0;
        double longitude = 0;
        String exceptionMessage = "No fuel prices found for adress: " + address + "with latitude and longitude: " + latitude + ", " + longitude;

        // Assert
        Exception ex = assertThrows(NotFoundException.class, () -> {
            // Act
            sut.getPrices(fuelType, address, latitude, longitude);
        });

        // Assert
        assertNotNull(ex);
        assertEquals(exceptionMessage, ex.getMessage());
    }

    @Test
    void getPricesByFuelTypeAddressAndLatitudeAndLongitudeWithLeewayReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "Diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        double latitudeLeeway = 51.9834048 + 0.00005;
        double longitudeLeeway = 5.4997363 - 0.00005;
        FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO(new PositionDTO(51.9834048, 5.4997363), "Rijksstraatweg 121C, 3921 AD Elst", 1.995);
        when(fuelPriceMapper.mapFuelPriceCSVRowToFuelPriceResponseDTO(anyList())).thenReturn(fuelPriceResponseDTO);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            List<FuelPriceResponseDTO> result = sut.getPrices(fuelType, address, latitudeLeeway, longitudeLeeway);

            // Assert
            assertNotNull(result);
            assertFalse(result.isEmpty());
            assertEquals(result.get(0), fuelPriceResponseDTO);
        });
    }
}