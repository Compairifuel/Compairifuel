package org.compairifuel.compairifuelapi.fuelprice.service;

import jakarta.enterprise.inject.Default;
import jakarta.ws.rs.InternalServerErrorException;
import jakarta.ws.rs.NotFoundException;
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
import java.io.UncheckedIOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Log(topic = "DataCSVFuelPriceServiceAdapteeImpl")
@Default
public class DataCSVFuelPriceServiceAdapteeImpl implements IFuelPriceServiceAggregatorAdapter {

    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address) {
        try {
            @Cleanup BufferedReader br = new BufferedReader(new InputStreamReader(getClass().getClassLoader().getResources("data.csv").nextElement().openStream()));

            List<List<String>> row = br.lines().map(line -> Arrays.asList(line.split(";"))).collect(Collectors.toList());

            List<FuelPriceResponseDTO> list = row.subList(1, row.size() - 1).stream().filter(column -> column.get(4).equals(fuelType) && column.get(0).equals(address)).map(column -> {
                FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO();
                fuelPriceResponseDTO.setAddress(column.get(0));
                fuelPriceResponseDTO.setPrice(Double.parseDouble(column.get(1)));
                fuelPriceResponseDTO.setPosition(new PositionDTO(Double.parseDouble(column.get(2)), Double.parseDouble(column.get(3))));
                return fuelPriceResponseDTO;
            }).collect(Collectors.toList());

            if (list.isEmpty()) {
                log.info("No fuel prices found for address: " + address);
                throw new NotFoundException("No fuel prices found for address: " + address);
            }

            return list;
        } catch (UncheckedIOException | IOException e) {
            log.severe("Error reading data.csv file: " + e.getMessage());
            throw new NotFoundException("No fuel prices found for address: " + address);
        }
    }

    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, double latitude, double longitude) {
        try {
            @Cleanup BufferedReader br = new BufferedReader(new InputStreamReader(getClass().getClassLoader().getResources("data.csv").nextElement().openStream()));

            List<List<String>> row = br.lines().map(line -> Arrays.asList(line.split(";"))).collect(Collectors.toList());

            // this is to add a 5m leeway to the latitude and longitude.
            double circa = 0.00005;

            List<FuelPriceResponseDTO> list = row.subList(1, row.size() - 1).stream().filter(column -> (column.get(4).equals(fuelType) && (Double.parseDouble(column.get(2)) <= (latitude + circa) && Double.parseDouble(column.get(2)) >= (latitude - circa)) && (Double.parseDouble(column.get(3)) <= longitude + circa && Double.parseDouble(column.get(3)) >= longitude - circa))
            ).map(column -> {
                FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO();
                fuelPriceResponseDTO.setAddress(column.get(0));
                fuelPriceResponseDTO.setPrice(Double.parseDouble(column.get(1)));
                fuelPriceResponseDTO.setPosition(new PositionDTO(Double.parseDouble(column.get(2)), Double.parseDouble(column.get(3))));
                return fuelPriceResponseDTO;
            }).collect(Collectors.toList());

            if (list.isEmpty()) {
                log.info("No fuel prices found for latitude and longitude: " + latitude + ", " + longitude);
                throw new NotFoundException("No fuel prices found for latitude and longitude: " + latitude + ", " + longitude);
            }

            return list;
        } catch (UncheckedIOException | IOException e) {
            log.severe("Error reading data.csv file: " + e.getMessage());
            throw new NotFoundException("No fuel prices found for address: " + latitude + ", " + longitude);
        }
    }

    @Override
    public List<FuelPriceResponseDTO> getPrices(String fuelType, String address, double latitude, double longitude) {
        try {
            @Cleanup BufferedReader br = new BufferedReader(new InputStreamReader(getClass().getClassLoader().getResources("data.csv").nextElement().openStream()));

            List<List<String>> row = br.lines().map(line -> Arrays.asList(line.split(";"))).collect(Collectors.toList());

            // this is to add a 5m leeway to the latitude and longitude.
            double circa = 0.00005;

            List<FuelPriceResponseDTO> list = row.subList(1, row.size() - 1).stream().filter(column -> (column.get(4).equals(fuelType) && (Double.parseDouble(column.get(2)) <= latitude + circa && Double.parseDouble(column.get(2)) >= latitude - circa) && (Double.parseDouble(column.get(3)) <= longitude + circa && Double.parseDouble(column.get(3)) >= longitude - circa) || column.get(0).equals(address))).map(column -> {
                FuelPriceResponseDTO fuelPriceResponseDTO = new FuelPriceResponseDTO();
                fuelPriceResponseDTO.setAddress(column.get(0));
                fuelPriceResponseDTO.setPrice(Double.parseDouble(column.get(1)));
                fuelPriceResponseDTO.setPosition(new PositionDTO(Double.parseDouble(column.get(2)), Double.parseDouble(column.get(3))));
                return fuelPriceResponseDTO;
            }).collect(Collectors.toList());
            if (list.isEmpty()) {
                log.info("No fuel prices found on adress:" + address + "with latitude and longitude: " + latitude + ", " + longitude);
                throw new NotFoundException("No fuel prices found on adress:" + address + "with latitude and longitude: " + latitude + ", " + longitude);
            }

            return list;
        } catch (UncheckedIOException | IOException e) {
            log.severe("Error reading data.csv file: " + e.getMessage());
            throw new NotFoundException("No fuel prices found for address: " + latitude + ", " + longitude);
        }
    }
}
