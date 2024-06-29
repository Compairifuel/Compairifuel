package org.compairifuel.compairifuelapi.gasstation.service;

import java.util.List;

public class ResultDomain {
    private String type;
    private String id;
    private double score;
    private double dist;
    private String info;
    private PoiDomain poi;
    private AddressDomain address;
    private GeoBiasDomain position;
    private ViewportDomain viewport;
    private List<EntryPointDomain> entryPoints;
    private List<String> fuelTypes;
    private List<String> vehicleTypes;
    private DataSourceDomain dataSources;
}
