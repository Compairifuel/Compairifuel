package org.compairifuel.compairifuelapi.gasstation.presentation;

import jakarta.ws.rs.NotFoundException;
import jakarta.ws.rs.core.Response;
import org.compairifuel.compairifuelapi.gasstation.service.IGasStationService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class GasStationControllerTest {
    private final GasStationController sut = new GasStationController();
    private IGasStationService gasStationService;
    private final int HTTP_OK = 200;

    @BeforeEach
    void setUp() {
        gasStationService = mock(IGasStationService.class);

        sut.setGasStationService(gasStationService);
    }

    @Test
    void getGasStationsReturnsListOfGasStationResponseDTO() {
        // Arrange
        double latitude = 51.987;
        double longitude = 5.922;
        List<GasStationResponseDTO> gasStationResponseDTOList = List.of(new GasStationResponseDTO());
        when(gasStationService.getGasStations(latitude, longitude, 25000)).thenReturn(gasStationResponseDTOList);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            Response response = sut.getGasStations(latitude, longitude);

            // Assert
            verify(gasStationService).getGasStations(latitude, longitude, 25000);
            assertNotNull(response);
            assertEquals(HTTP_OK, response.getStatus());
            assertInstanceOf(List.class, response.getEntity());
            assertNotNull(response.getEntity());
            assertNotEquals(List.of(), response.getEntity());
            assertEquals(gasStationResponseDTOList, response.getEntity());
        });
    }

    @Test
    void getGasStationsThrowsNotFoundException() {
        // Arrange
        double latitude = 51.987;
        double longitude = 5.922;
        String exceptionMessage = "No gas stations found for latitude: " + latitude + " and longitude: " + longitude;
        when(gasStationService.getGasStations(latitude, longitude, 25000)).thenThrow(new NotFoundException(exceptionMessage));

        // Assert
        Exception ex = assertThrows(NotFoundException.class,() -> {
            // Act
            sut.getGasStations(latitude, longitude);
        });
        assertEquals(exceptionMessage, ex.getMessage());
    }
}