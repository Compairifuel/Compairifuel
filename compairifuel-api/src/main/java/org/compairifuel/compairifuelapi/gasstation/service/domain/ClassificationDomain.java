package org.compairifuel.compairifuelapi.gasstation.service.domain;

import lombok.Data;

import java.util.List;

@Data
public class ClassificationDomain {
    private String code;
    private List<NameDomain> names;
}
