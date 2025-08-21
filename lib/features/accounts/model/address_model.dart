class AddressModel {
  final String name;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String pinCode;
  final String type; // shipping, billing, etc.
  final bool isDefault;

  AddressModel({
    required this.name,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.pinCode,
    required this.type,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['name'] ?? '',
      addressLine1: json['addressLine1'] ?? '',
      addressLine2: json['addressLine2'] ?? '',
      city: json['city'] ?? '',
      pinCode: json['pinCode'] ?? '',
      type: json['type'] ?? 'shipping',
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'pinCode': pinCode,
      'type': type,
      'isDefault': isDefault,
    };
  }
}
