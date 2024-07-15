package org.compairifuel.compairifuelapi.gasstation.service.domain;

import lombok.Data;

@Data
public class EntryPointDomain {
    private String type;
    private GeoBiasDomain position;
}
