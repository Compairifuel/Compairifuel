package org.compairifuel.compairifuelapi.gasstation.service.domain;

import lombok.Data;

@Data
public class SummaryDomain {
    private String queryType;
    private int queryTime;
    private int numResults;
    private int offset;
    private int totalResults;
    private int fuzzyLevel;
    private GeoBiasDomain geoBias;
}
