package org.compairifuel.compairifuelapi.fuelprice.presentation;

import jakarta.ws.rs.NotFoundException;
import jakarta.ws.rs.core.Response;
import org.compairifuel.compairifuelapi.authorization.presentation.AuthCodeValidatorController;
import org.compairifuel.compairifuelapi.fuelprice.service.IFuelPriceService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class FuelPriceControllerTest {
    private final FuelPriceController sut = new FuelPriceController();
    private IFuelPriceService fuelPriceService;
    private AuthCodeValidatorController authCodeValidatorController;
    private final int HTTP_OK = 200;

    @BeforeEach
    void setUp() {
        fuelPriceService = mock(IFuelPriceService.class);
        authCodeValidatorController = mock(AuthCodeValidatorController.class);

        sut.setFuelPriceService(fuelPriceService);
        sut.setAuthCodeValidatorController(authCodeValidatorController);

        when(authCodeValidatorController.authenticateToken(anyString())).thenReturn(true);
    }

    @Test
    void getPricesReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        List<FuelPriceResponseDTO> fuelPriceResponseDTOList = List.of(new FuelPriceResponseDTO());
        when(fuelPriceService.getPrices(fuelType, address)).thenReturn(fuelPriceResponseDTOList);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            Response response = sut.getPrices(fuelType, address, "Bearer token");

            // Assert
            verify(fuelPriceService).getPrices(fuelType, address);
            assertNotNull(response);
            assertEquals(HTTP_OK, response.getStatus());
            assertInstanceOf(List.class, response.getEntity());
            assertNotNull(response.getEntity());
            assertNotEquals(List.of(), response.getEntity());
            assertEquals(fuelPriceResponseDTOList, response.getEntity());
        });
    }

    @Test
    void getPricesThrowsNotFoundException() {
        // Arrange
        String fuelType = "diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        String exceptionMessage = "No fuel prices found for address: " + address;
        when(fuelPriceService.getPrices(fuelType, address)).thenThrow(new NotFoundException(exceptionMessage));

        // Assert
        Exception ex = assertThrows(NotFoundException.class, () -> {
            // Act
            sut.getPrices(fuelType, address, "Bearer token");
        });
        assertEquals(exceptionMessage, ex.getMessage());
    }

    @Test
    void getPricesWithFuelTypeLatitudeAndLongitudeReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "diesel";
        double latitude = 51.987;
        double longitude = 5.922;
        List<FuelPriceResponseDTO> fuelPriceResponseDTOList = List.of(new FuelPriceResponseDTO());
        when(fuelPriceService.getPrices(fuelType, latitude, longitude)).thenReturn(fuelPriceResponseDTOList);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            Response response = sut.getPrices(fuelType, latitude, longitude,"Bearer token");

            // Assert
            verify(fuelPriceService).getPrices(fuelType, latitude, longitude);
            assertNotNull(response);
            assertEquals(HTTP_OK, response.getStatus());
            assertInstanceOf(List.class, response.getEntity());
            assertNotNull(response.getEntity());
            assertNotEquals(List.of(), response.getEntity());
            assertEquals(fuelPriceResponseDTOList, response.getEntity());
        });
    }

    @Test
    void getPricesWithFuelTypeLatitudeAndLongitudeThrowsNotFoundException() {
        // Arrange
        String fuelType = "diesel";
        double latitude = 51.987;
        double longitude = 5.922;
        String exceptionMessage = "No fuel prices found for latitude and longitude: " + latitude + ", " + longitude;
        when(fuelPriceService.getPrices(fuelType, latitude, longitude)).thenThrow(new NotFoundException(exceptionMessage));

        // Assert
        Exception ex = assertThrows(NotFoundException.class, () -> {
            // Act
            sut.getPrices(fuelType, latitude, longitude, "Bearer token");
        });
        assertEquals(exceptionMessage, ex.getMessage());
    }

    @Test
    void getPricesWithFuelTypeAddressLatitudeAndLongitudeReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        double latitude = 51.987;
        double longitude = 5.922;
        List<FuelPriceResponseDTO> fuelPriceResponseDTOList = List.of(new FuelPriceResponseDTO());
        when(fuelPriceService.getPrices(fuelType, address, latitude, longitude)).thenReturn(fuelPriceResponseDTOList);

        // Assert
        assertDoesNotThrow(() -> {
            // Act
            Response response = sut.getPrices(fuelType, address, latitude, longitude, "Bearer token");

            // Assert
            verify(fuelPriceService).getPrices(fuelType, address, latitude, longitude);
            assertNotNull(response);
            assertEquals(HTTP_OK, response.getStatus());
            assertInstanceOf(List.class, response.getEntity());
            assertNotNull(response.getEntity());
            assertNotEquals(List.of(), response.getEntity());
            assertEquals(fuelPriceResponseDTOList, response.getEntity());
        });
    }

    @Test
    void getPricesWithFuelTypeAddressLatitudeAndLongitudeThrowsNotFoundException() {
        // Arrange
        String fuelType = "diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        double latitude = 51.987;
        double longitude = 5.922;
        String exceptionMessage = "No fuel prices found for latitude and longitude: " + latitude + ", " + longitude;
        when(fuelPriceService.getPrices(fuelType, address, latitude, longitude)).thenThrow(new NotFoundException(exceptionMessage));

        // Assert
        Exception ex = assertThrows(NotFoundException.class, () -> {
            // Act
            sut.getPrices(fuelType, address, latitude, longitude, "Bearer token");
        });
        assertEquals(exceptionMessage, ex.getMessage());
    }

}
