package org.compairifuel.compairifuelapi.gasstation.service;

import lombok.Data;

import java.util.List;

@Data
public class GasStationDomain {
    private SummaryDomain summary;
    private List<ResultDomain> results;
}
