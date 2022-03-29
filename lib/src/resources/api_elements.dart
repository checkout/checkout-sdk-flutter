class BillingAddress {
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? zip;
  String? country;

  BillingAddress({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  BillingAddress.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['address_line1'] as String?;
    addressLine2 = json['address_line2'] as String?;
    city = json['city'] as String?;
    state = json['state'] as String?;
    zip = json['zip'] as String?;
    country = json['country'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['address_line1'] = addressLine1;
    json['address_line2'] = addressLine2;
    json['city'] = city;
    json['state'] = state;
    json['zip'] = zip;
    json['country'] = country;
    return json;
  }
}

class Phone {
  String? number;
  String? countryCode;

  Phone({
    this.number,
    this.countryCode,
  });

  Phone.fromJson(Map<String, dynamic> json) {
    number = json['number'] as String?;
    countryCode = json['country_code'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['number'] = number;
    json['country_code'] = countryCode;
    return json;
  }
}

class AppleTokenData {
  late String version;
  late String data;
  late String signature;
  late AppleHeader header;

  AppleTokenData({
    required this.version,
    required this.data,
    required this.signature,
    required this.header,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['version'] = version;
    json['data'] = data;
    json['signature'] = signature;
    json['header'] = header;
    return json;
  }
}

class AppleHeader {
  late String ephemeralPublicKey;
  late String publicKeyHash;
  late String transactionId;

  AppleHeader({
    required this.ephemeralPublicKey,
    required this.publicKeyHash,
    required this.transactionId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ephemeralPublicKey'] = ephemeralPublicKey;
    json['publicKeyHash'] = publicKeyHash;
    json['transactionId'] = transactionId;
    return json;
  }
}

class GoogleTokenData {
  late String signature;
  late String protocolVersion;
  late String signedMessage;

  GoogleTokenData({
    required this.signature,
    required this.protocolVersion,
    required this.signedMessage,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['signature'] = signature;
    json['protocolVersion'] = protocolVersion;
    json['signedMessage'] = signedMessage;
    return json;
  }
}
