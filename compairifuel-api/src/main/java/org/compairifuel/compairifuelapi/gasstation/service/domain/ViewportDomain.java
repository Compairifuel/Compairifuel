package org.compairifuel.compairifuelapi.gasstation.service.domain;

import lombok.Data;

@Data
public class ViewportDomain {
    private GeoBiasDomain topLeftPoint;
    private GeoBiasDomain btmRightPoint;
}
