package org.compairifuel.compairifuelapi.fuelprice.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class DataCSVFuelPriceServiceAdapteeImplTest {
    private final DataCSVFuelPriceServiceAdapteeImpl sut = new DataCSVFuelPriceServiceAdapteeImpl();

    @BeforeEach
    void setUp(){

    }

    @Test
    void getPricesReturnsListOfFuelPriceResponseDTO() {
        // Arrange
        String fuelType = "Diesel";
        String address = "Rijksstraatweg 121C, 3921 AD Elst";
        // Act
        var result = sut.getPrices(fuelType, address);
        // Assert
        assertNotNull(result);
        assertNotEquals(0, result.size());
    }
}