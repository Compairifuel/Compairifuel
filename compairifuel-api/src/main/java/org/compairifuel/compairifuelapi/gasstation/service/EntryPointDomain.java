package org.compairifuel.compairifuelapi.gasstation.service;

import lombok.Data;

@Data
public class EntryPointDomain {
    private String type;
    private GeoBiasDomain position;
}
