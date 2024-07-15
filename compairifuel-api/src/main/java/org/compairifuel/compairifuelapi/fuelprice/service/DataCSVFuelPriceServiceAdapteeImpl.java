package org.compairifuel.compairifuelapi.fuelprice.service;

import jakarta.enterprise.inject.Default;
import jakarta.ws.rs.core.MultivaluedHashMap;
import lombok.Cleanup;
import lombok.extern.java.Log;
import org.compairifuel.compairifuelapi.fuelprice.presentation.FuelPriceResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.presentation.GasStationResponseDTO;
import org.compairifuel.compairifuelapi.gasstation.service.IGasStationsServiceAggregatorAdapter;
import org.compairifuel.compairifuelapi.gasstation.service.domain.GasStationDomain;
import org.compairifuel.compairifuelapi.gasstation.service.domain.ResultDomain;
import org.compairifuel.compairifuelapi.utils.presentation.PositionDTO;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Log(topic = "DataCSVGasStationServiceAdapteeImpl")
@Default
public class DataCSVFuelPriceServiceAdapteeImpl implements IFuelPriceServiceAggregatorAdapter {

    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address) throws IOException {
        // read from csv as a stream and then search for address in the stream and return the row. from the file data.csv in resources.
        @Cleanup BufferedReader br = new BufferedReader(new InputStreamReader(Objects.requireNonNull(getClass().getClassLoader().getResourceAsStream("data.csv"))));

        List<List<String>> row = br.lines().map(line -> Arrays.asList(line.split(";"))).collect(Collectors.toList());

        return row.subList(1, row.size() - 1).stream().filter(strings -> strings.get(0).equals(address)).map(strings -> {
            FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO();
            fuelPriceResponseDTO.setAddress(strings.get(0));
            fuelPriceResponseDTO.setPrice(Double.parseDouble(strings.get(1)));
            fuelPriceResponseDTO.setPosition(new PositionDTO(Double.parseDouble(strings.get(2)), Double.parseDouble(strings.get(3))));
            return fuelPriceResponseDTO;
        }).collect(Collectors.toList());
    }
}
