package org.compairifuel.compairifuelapi.gasstation.mapper;

import jakarta.ws.rs.InternalServerErrorException;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.service.TomTomGasStationServiceAdapteeImpl;
import org.compairifuel.compairifuelapi.gasstation.service.domain.*;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class GasStationMapperImplTest {
    private final GasStationMapperImpl sut = new GasStationMapperImpl();
    private final ResultDomain resultDomainReturnsCorrectly = new ResultDomain();
    private final ResultDomain resultDomainThrowsInternalServerErrorException = new ResultDomain();
    private final GasStationResponseDTO gasStationResponseDTO = new GasStationResponseDTO();
    private final PoiDomain poi = new PoiDomain();
    private final GeoBiasDomain geoBias = new GeoBiasDomain();
    private final EntryPointDomain entryPointDomain = new EntryPointDomain();
    private final ViewportDomain viewportDomain = new ViewportDomain();
    private final PositionDTO position = new PositionDTO(1,1);

    @BeforeEach
    void setUp(){
        poi.setName("poi");
        geoBias.setLon(1);
        geoBias.setLat(1);
        entryPointDomain.setPosition(geoBias);
        viewportDomain.setTopLeftPoint(geoBias);
        viewportDomain.setBtmRightPoint(geoBias);

        resultDomainReturnsCorrectly.setId("d");
        resultDomainReturnsCorrectly.setAddress(new AddressDomain());
        resultDomainReturnsCorrectly.setPoi(poi);
        resultDomainReturnsCorrectly.setPosition(geoBias);
        resultDomainReturnsCorrectly.setEntryPoints(List.of(entryPointDomain));
        resultDomainReturnsCorrectly.setViewport(viewportDomain);

        gasStationResponseDTO.setId("d");
        gasStationResponseDTO.setName("poi");
        gasStationResponseDTO.setAddress(null);
        gasStationResponseDTO.setName("poi");
        gasStationResponseDTO.setPosition(position);
        gasStationResponseDTO.setEntryPoints(List.of(position));
        gasStationResponseDTO.setViewport(List.of(position,position));

    }

    @Test
    void mappingResultDomainToGasStationResponseDTOReturnsCorrectly(){
        // Assert
        assertDoesNotThrow(()-> {
            // Act
            GasStationResponseDTO result = sut.mapResultDomainToGasStationResponseDTO(resultDomainReturnsCorrectly);

            // Assert
            assertNotNull(result);
            assertEquals(gasStationResponseDTO, result);
        });
    }

    @Test
    void mappingResultDomainToGasStationResponseDTOThrowsInternalServerErrorException(){
        // Assert
        assertThrows(InternalServerErrorException.class,()-> sut.mapResultDomainToGasStationResponseDTO(resultDomainThrowsInternalServerErrorException));
    }
}
