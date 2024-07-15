package org.compairifuel.compairifuelapi.gasstation.service.domain;

import lombok.Data;

import java.util.List;

@Data
public class PoiDomain {
    private String name;
    private List<CategorySetDomain> categorySet;
    private List<String> categories;
    private List<ClassificationDomain> classifications;
    private String url;
    private List<BrandDomain> brands;
    private String phone;
}
