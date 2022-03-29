import 'package:checkout_sdk_flutter/src/resources/api_elements.dart';

class CardTokenizationRequest {
  String? type;
  late String number;
  late int expiryMonth;
  late int expiryYear;
  String? cvv;
  String? name;
  BillingAddress? billingAddress;
  Phone? phone;

  CardTokenizationRequest({
    this.type,
    required this.number,
    required this.expiryMonth,
    required this.expiryYear,
    this.cvv,
    this.name,
    this.billingAddress,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['type'] = "card";
    json['number'] = number;
    json['expiry_month'] = expiryMonth;
    json['expiry_year'] = expiryYear;
    json['cvv'] = cvv;
    json['name'] = name;
    json['billing_address'] = billingAddress?.toJson();
    json['phone'] = phone?.toJson();
    return json;
  }
}

class ApplePayTokenizationRequest {
  String? type;
  late AppleTokenData tokenData;

  ApplePayTokenizationRequest({
    this.type,
    required this.tokenData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['type'] = "applepay";
    json['token_data'] = tokenData.toJson();
    return json;
  }
}

class GooglePayTokenizationRequest {
  String? type;
  late GoogleTokenData tokenData;

  GooglePayTokenizationRequest({
    this.type,
    required this.tokenData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['type'] = "googlepay";
    json['token_data'] = tokenData.toJson();
    return json;
  }
}
