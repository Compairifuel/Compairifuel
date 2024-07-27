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
        @Cleanup BufferedReader br = new BufferedReader(new InputStreamReader(Objects.requireNonNull(getClass().getClassLoader().getResourceAsStream("data.csv"))));

        List<List<String>> row = br.lines().map(line -> Arrays.asList(line.split(";"))).collect(Collectors.toList());

        return row.subList(1, row.size() - 1).stream().filter(column -> column.get(0).equals(address)).map(column -> {
            FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO();
            fuelPriceResponseDTO.setAddress(column.get(0));
            fuelPriceResponseDTO.setPrice(Double.parseDouble(column.get(1)));
            fuelPriceResponseDTO.setPosition(new PositionDTO(Double.parseDouble(column.get(2)), Double.parseDouble(column.get(3))));
            return fuelPriceResponseDTO;
        }).collect(Collectors.toList());
    }

    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, double latitude, double longitude) throws IOException {
        @Cleanup BufferedReader br = new BufferedReader(new InputStreamReader(Objects.requireNonNull(getClass().getClassLoader().getResourceAsStream("data.csv"))));

        List<List<String>> row = br.lines().map(line -> Arrays.asList(line.split(";"))).collect(Collectors.toList());

        // this is to add a 5m leeway to the latitude and longitude.
        double circa = 0.00005;

        // 51.9875311
        // + 0.00005
        // 51.9875811
        // 51.9875311 <= 51.9875311 + 0.00005

        // 51.9875311
        // - 0.00005
        // 51.9874811
        // 51.9875311 >= 51.9875311 - 0.00005

        return row.subList(1, row.size() - 1).stream().filter(column -> (Double.parseDouble(column.get(2)) <= (latitude + circa) && Double.parseDouble(column.get(2)) >= (latitude - circa)) && (Double.parseDouble(column.get(3)) <= longitude + circa && Double.parseDouble(column.get(3)) >= longitude - circa)
        ).map(column -> {
            FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO();
            fuelPriceResponseDTO.setAddress(column.get(0));
            fuelPriceResponseDTO.setPrice(Double.parseDouble(column.get(1)));
            fuelPriceResponseDTO.setPosition(new PositionDTO(Double.parseDouble(column.get(2)), Double.parseDouble(column.get(3))));
            return fuelPriceResponseDTO;
        }).collect(Collectors.toList());
    }

    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address, double latitude, double longitude) throws IOException {
        @Cleanup BufferedReader br = new BufferedReader(new InputStreamReader(Objects.requireNonNull(getClass().getClassLoader().getResourceAsStream("data.csv"))));

        List<List<String>> row = br.lines().map(line -> Arrays.asList(line.split(";"))).collect(Collectors.toList());

        // this is to add a 5m leeway to the latitude and longitude.
        double circa = 0.00005;

        return row.subList(1, row.size() - 1).stream().filter(column -> (Double.parseDouble(column.get(2)) <= latitude + circa && Double.parseDouble(column.get(2)) >= latitude - circa) && (Double.parseDouble(column.get(3)) <= longitude + circa && Double.parseDouble(column.get(3)) >= longitude - circa) || column.get(0).equals(address)).map(column -> {
            FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO();
            fuelPriceResponseDTO.setAddress(column.get(0));
            fuelPriceResponseDTO.setPrice(Double.parseDouble(column.get(1)));
            fuelPriceResponseDTO.setPosition(new PositionDTO(Double.parseDouble(column.get(2)), Double.parseDouble(column.get(3))));
            return fuelPriceResponseDTO;
        }).collect(Collectors.toList());
    }
}
