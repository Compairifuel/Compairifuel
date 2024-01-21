class Autogenerated {
  Summary? summary;
  List<Results>? results;

  Autogenerated({this.summary, this.results});

  factory Autogenerated.fromJson(Map<String, dynamic> json) {
    return Autogenerated(
      summary: json['summary'] != null ? Summary.fromJson(json['summary']) : null,
      results: (json['results'] as List<dynamic>?)
          ?.map((result) => Results.fromJson(result))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (summary != null) data['summary'] = summary!.toJson();
    if (results != null) data['results'] = results!.map((result) => result.toJson()).toList();
    return data;
  }
}

class Summary {
  String? queryType;
  int? queryTime;
  int? numResults;
  int? offset;
  int? totalResults;
  int? fuzzyLevel;
  GeoBias? geoBias;

  Summary(
      {this.queryType,
      this.queryTime,
      this.numResults,
      this.offset,
      this.totalResults,
      this.fuzzyLevel,
      this.geoBias});

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      queryType: json['queryType'],
      queryTime: json['queryTime'],
      numResults: json['numResults'],
      offset: json['offset'],
      totalResults: json['totalResults'],
      fuzzyLevel: json['fuzzyLevel'],
      geoBias: json['geoBias'] != null ? GeoBias.fromJson(json['geoBias']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['queryType'] = queryType;
    data['queryTime'] = queryTime;
    data['numResults'] = numResults;
    data['offset'] = offset;
    data['totalResults'] = totalResults;
    data['fuzzyLevel'] = fuzzyLevel;
    if (geoBias != null) {
      data['geoBias'] = geoBias!.toJson();
    }
    return data;
  }
}

class GeoBias {
  double? lat;
  double? lon;

  GeoBias({this.lat, this.lon});

  factory GeoBias.fromJson(Map<String, dynamic> json) {
    return GeoBias(
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}

class Results {
  String? type;
  String? id;
  double? score;
  double? dist;
  String? info;
  Poi? poi;
  Address? address;
  GeoBias? position;
  Viewport? viewport;
  List<EntryPoints>? entryPoints;
  List<String>? fuelTypes;
  List<String>? vehicleTypes;
  DataSources? dataSources;

  Results(
      {this.type,
      this.id,
      this.score,
      this.dist,
      this.info,
      this.poi,
      this.address,
      this.position,
      this.viewport,
      this.entryPoints,
      this.fuelTypes,
      this.vehicleTypes,
      this.dataSources});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      type: json['type'],
      id: json['id'],
      score: json['score'],
      dist: json['dist'],
      info: json['info'],
      poi: json['poi'] != null ? Poi.fromJson(json['poi']) : null,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      position: json['position'] != null ? GeoBias.fromJson(json['position']) : null,
      viewport: json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null,
      entryPoints: (json['entryPoints'] as List<dynamic>?)
          ?.map((entryPoint) => EntryPoints.fromJson(entryPoint))
          .toList(),
      fuelTypes: (json['fuelTypes'] as List<dynamic>?)?.cast<String>(),
      vehicleTypes: (json['vehicleTypes'] as List<dynamic>?)?.cast<String>(),
      dataSources: json['dataSources'] != null ? DataSources.fromJson(json['dataSources']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['score'] = score;
    data['dist'] = dist;
    data['info'] = info;
    if (poi != null) {
      data['poi'] = poi!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (position != null) {
      data['position'] = position!.toJson();
    }
    if (viewport != null) {
      data['viewport'] = viewport!.toJson();
    }
    if (entryPoints != null) {
      data['entryPoints'] = entryPoints!.map((v) => v.toJson()).toList();
    }
    data['fuelTypes'] = fuelTypes;
    data['vehicleTypes'] = vehicleTypes;
    if (dataSources != null) {
      data['dataSources'] = dataSources!.toJson();
    }
    return data;
  }
}

class Poi {
  String? name;
  List<CategorySet>? categorySet;
  List<String>? categories;
  List<Classifications>? classifications;
  String? url;
  List<Brands>? brands;
  String? phone;

  Poi(
      {this.name,
      this.categorySet,
      this.categories,
      this.classifications,
      this.url,
      this.brands,
      this.phone});

  factory Poi.fromJson(Map<String, dynamic> json) {
    return Poi(
      name: json['name'],
      categorySet: (json['categorySet'] as List<dynamic>?)
          ?.map((category) => CategorySet.fromJson(category))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)?.cast<String>(),
      classifications: (json['classifications'] as List<dynamic>?)
          ?.map((classification) => Classifications.fromJson(classification))
          .toList(),
      url: json['url'],
      brands: (json['brands'] as List<dynamic>?)
          ?.map((brand) => Brands.fromJson(brand))
          .toList(),
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (categorySet != null) {
      data['categorySet'] = categorySet!.map((v) => v.toJson()).toList();
    }
    data['categories'] = categories;
    if (classifications != null) {
      data['classifications'] =
          classifications!.map((v) => v.toJson()).toList();
    }
    data['url'] = url;
    if (brands != null) {
      data['brands'] = brands!.map((v) => v.toJson()).toList();
    }
    data['phone'] = phone;
    return data;
  }
}

class CategorySet {
  int? id;

  CategorySet({this.id});

  factory CategorySet.fromJson(Map<String, dynamic> json) {
    return CategorySet(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Classifications {
  String? code;
  List<Names>? names;

  Classifications({this.code, this.names});

  factory Classifications.fromJson(Map<String, dynamic> json) {
    return Classifications(
      code: json['code'],
      names: (json['names'] as List<dynamic>?)
          ?.map((name) => Names.fromJson(name))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (names != null) {
      data['names'] = names!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Names {
  String? nameLocale;
  String? name;

  Names({this.nameLocale, this.name});

  factory Names.fromJson(Map<String, dynamic> json) {
    return Names(
      nameLocale: json['nameLocale'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameLocale'] = nameLocale;
    data['name'] = name;
    return data;
  }
}

class Brands {
  String? name;

  Brands({this.name});

  factory Brands.fromJson(Map<String, dynamic> json) {
    return Brands(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Address {
  String? streetNumber;
  String? streetName;
  String? municipality;
  String? countrySubdivision;
  String? countrySubdivisionName;
  String? countrySubdivisionCode;
  String? postalCode;
  String? extendedPostalCode;
  String? countryCode;
  String? country;
  String? countryCodeISO3;
  String? freeformAddress;
  String? localName;
  String? municipalitySubdivision;

  Address(
      {this.streetNumber,
      this.streetName,
      this.municipality,
      this.countrySubdivision,
      this.countrySubdivisionName,
      this.countrySubdivisionCode,
      this.postalCode,
      this.extendedPostalCode,
      this.countryCode,
      this.country,
      this.countryCodeISO3,
      this.freeformAddress,
      this.localName,
      this.municipalitySubdivision});

  Address.fromJson(Map<String, dynamic> json) {
    streetNumber = json['streetNumber'];
    streetName = json['streetName'];
    municipality = json['municipality'];
    countrySubdivision = json['countrySubdivision'];
    countrySubdivisionName = json['countrySubdivisionName'];
    countrySubdivisionCode = json['countrySubdivisionCode'];
    postalCode = json['postalCode'];
    extendedPostalCode = json['extendedPostalCode'];
    countryCode = json['countryCode'];
    country = json['country'];
    countryCodeISO3 = json['countryCodeISO3'];
    freeformAddress = json['freeformAddress'];
    localName = json['localName'];
    municipalitySubdivision = json['municipalitySubdivision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['streetNumber'] = streetNumber;
    data['streetName'] = streetName;
    data['municipality'] = municipality;
    data['countrySubdivision'] = countrySubdivision;
    data['countrySubdivisionName'] = countrySubdivisionName;
    data['countrySubdivisionCode'] = countrySubdivisionCode;
    data['postalCode'] = postalCode;
    data['extendedPostalCode'] = extendedPostalCode;
    data['countryCode'] = countryCode;
    data['country'] = country;
    data['countryCodeISO3'] = countryCodeISO3;
    data['freeformAddress'] = freeformAddress;
    data['localName'] = localName;
    data['municipalitySubdivision'] = municipalitySubdivision;
    return data;
  }
}

class Viewport {
  GeoBias? topLeftPoint;
  GeoBias? btmRightPoint;

  Viewport({this.topLeftPoint, this.btmRightPoint});

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      topLeftPoint: json['topLeftPoint'] != null
          ? GeoBias.fromJson(json['topLeftPoint'])
          : null,
      btmRightPoint: json['btmRightPoint'] != null
          ? GeoBias.fromJson(json['btmRightPoint'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topLeftPoint != null) {
      data['topLeftPoint'] = topLeftPoint!.toJson();
    }
    if (btmRightPoint != null) {
      data['btmRightPoint'] = btmRightPoint!.toJson();
    }
    return data;
  }
}

class EntryPoints {
  String? type;
  GeoBias? position;

  EntryPoints({this.type, this.position});

  factory EntryPoints.fromJson(Map<String, dynamic> json) {
    return EntryPoints(
      type: json['type'],
      position: json['position'] != null
          ? GeoBias.fromJson(json['position'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (position != null) {
      data['position'] = position!.toJson();
    }
    return data;
  }
}

class DataSources {
  FuelPrice? fuelPrice;

  DataSources({this.fuelPrice});

  factory DataSources.fromJson(Map<String, dynamic> json) {
    return DataSources(
      fuelPrice: json['fuelPrice'] != null ? FuelPrice.fromJson(json['fuelPrice']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fuelPrice != null) {
      data['fuelPrice'] = fuelPrice!.toJson();
    }
    return data;
  }
}

class FuelPrice {
  String id;

  FuelPrice({required this.id});

  factory FuelPrice.fromJson(Map<String, dynamic> json) {
    return FuelPrice(
        id: json['id']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
