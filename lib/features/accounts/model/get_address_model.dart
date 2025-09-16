import 'dart:convert';

GetAddressModel getAddressModelFromJson(String str) =>
    GetAddressModel.fromJson(json.decode(str));

String getAddressModelToJson(GetAddressModel data) =>
    json.encode(data.toJson());

class GetAddressModel {
  Data? data;
  Extensions? extensions;

  GetAddressModel({this.data, this.extensions});

  factory GetAddressModel.fromJson(Map<String, dynamic> json) =>
      GetAddressModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        extensions:
            json["extensions"] == null
                ? null
                : Extensions.fromJson(json["extensions"]),
      );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "extensions": extensions?.toJson(),
  };
}

class Data {
  List<CustomerAddress>? customerAddresses;

  Data({this.customerAddresses});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerAddresses:
        json["customerAddresses"] == null
            ? []
            : List<CustomerAddress>.from(
              json["customerAddresses"]!.map(
                (x) => CustomerAddress.fromJson(x),
              ),
            ),
  );

  Map<String, dynamic> toJson() => {
    "customerAddresses":
        customerAddresses == null
            ? []
            : List<dynamic>.from(customerAddresses!.map((x) => x.toJson())),
  };
}

class CustomerAddress {
  int? id;
  String? addressType;
  String? addressLabel;
  String? firstName;
  String? lastName;
  String? company;
  String? country;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? phone;
  String? email;
  int? isDefault;

  CustomerAddress({
    this.id,
    this.addressType,
    this.addressLabel,
    this.firstName,
    this.lastName,
    this.company,
    this.country,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.phone,
    this.email,
    this.isDefault,
  });

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      CustomerAddress(
        id: json["id"],
        addressType: json["address_type"],
        addressLabel: json["address_label"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        country: json["country"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        phone: json["phone"],
        email: json["email"],
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address_type": addressType,
    "address_label": addressLabel,
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "country": country,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "phone": phone,
    "email": email,
    "is_default": isDefault,
  };
}

class Extensions {
  List<dynamic>? debug;
  QueryAnalyzer? queryAnalyzer;

  Extensions({this.debug, this.queryAnalyzer});

  factory Extensions.fromJson(Map<String, dynamic> json) => Extensions(
    debug:
        json["debug"] == null
            ? []
            : List<dynamic>.from(json["debug"]!.map((x) => x)),
    queryAnalyzer:
        json["queryAnalyzer"] == null
            ? null
            : QueryAnalyzer.fromJson(json["queryAnalyzer"]),
  );

  Map<String, dynamic> toJson() => {
    "debug": debug == null ? [] : List<dynamic>.from(debug!.map((x) => x)),
    "queryAnalyzer": queryAnalyzer?.toJson(),
  };
}

class QueryAnalyzer {
  String? keys;
  int? keysLength;
  int? keysCount;
  String? skippedKeys;
  int? skippedKeysSize;
  int? skippedKeysCount;
  List<dynamic>? skippedTypes;

  QueryAnalyzer({
    this.keys,
    this.keysLength,
    this.keysCount,
    this.skippedKeys,
    this.skippedKeysSize,
    this.skippedKeysCount,
    this.skippedTypes,
  });

  factory QueryAnalyzer.fromJson(Map<String, dynamic> json) => QueryAnalyzer(
    keys: json["keys"],
    keysLength: json["keysLength"],
    keysCount: json["keysCount"],
    skippedKeys: json["skippedKeys"],
    skippedKeysSize: json["skippedKeysSize"],
    skippedKeysCount: json["skippedKeysCount"],
    skippedTypes:
        json["skippedTypes"] == null
            ? []
            : List<dynamic>.from(json["skippedTypes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "keys": keys,
    "keysLength": keysLength,
    "keysCount": keysCount,
    "skippedKeys": skippedKeys,
    "skippedKeysSize": skippedKeysSize,
    "skippedKeysCount": skippedKeysCount,
    "skippedTypes":
        skippedTypes == null
            ? []
            : List<dynamic>.from(skippedTypes!.map((x) => x)),
  };
}
