package org.compairifuel.compairifuelapi.gasstation.service;

import jakarta.ws.rs.NotFoundException;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class GasStationServiceImplTest {
    private final GasStationServiceImpl sut = new GasStationServiceImpl();
    private IGasStationsServiceAggregatorAdapter gasStationsServiceAggregatorAdaptee;

    @BeforeEach
    void setUp() {
        gasStationsServiceAggregatorAdaptee = mock(IGasStationsServiceAggregatorAdapter.class);

        sut.setGasStationsServiceAggregatorAdapter(gasStationsServiceAggregatorAdaptee);
    }

    @Test
    void getGasStationsReturnsListOfGasStationResponseDTO() {
        // Arrange
        double latitude = 10;
        double longitude = 455;
        int radius = 25000;
        GasStationResponseDTO gasStationResponseDTO = new GasStationResponseDTO();
        List<GasStationResponseDTO> gasStationResponseDTOList = List.of(gasStationResponseDTO);
        when(gasStationsServiceAggregatorAdaptee.getGasStations(latitude, longitude, radius)).thenReturn(gasStationResponseDTOList);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            List<GasStationResponseDTO> results = sut.getGasStations(latitude, longitude, radius);

            // Assert
            assertNotNull(results);
            assertInstanceOf(List.class, results);
            assertNotEquals(List.of(), results);
            assertEquals(results.get(0), gasStationResponseDTO);
        });
    }

    @Test
    void getGasStationsThrowsNotFoundException() {
        // Arrange
        double latitude = 10;
        double longitude = 455;
        int radius = 25000;
        String exceptionMessage = "No gas stations found for latitude: " + latitude + " and longitude: " + longitude;
        when(gasStationsServiceAggregatorAdaptee.getGasStations(latitude, longitude, radius)).thenThrow(new NotFoundException(exceptionMessage));

        // Assert
        Exception ex = assertThrows(NotFoundException.class, () -> {
            // Act
            sut.getGasStations(latitude, longitude, radius);
        });
        assertEquals(exceptionMessage, ex.getMessage());
    }
}