import 'package:checkout_sdk_flutter/src/resources/api_elements.dart';

class CardTokenizationResponse {
  late String type;
  late String token;
  late String expiresOn;
  late int expiryMonth;
  late int expiryYear;
  String? scheme;
  late String last4;
  late String bin;
  String? cardType;
  String? cardCategory;
  String? issuer;
  String? issuerCountry;
  String? productId;
  String? productType;
  BillingAddress? billingAddress;
  Phone? phone;
  String? name;

  CardTokenizationResponse({
    required this.type,
    required this.token,
    required this.expiresOn,
    required this.expiryMonth,
    required this.expiryYear,
    this.scheme,
    required this.last4,
    required this.bin,
    this.cardType,
    this.cardCategory,
    this.issuer,
    this.issuerCountry,
    this.productId,
    this.productType,
    this.billingAddress,
    this.phone,
    this.name,
  });

  CardTokenizationResponse.fromJson(Map<String, dynamic> json) {
    type = (json['type'] as String?)!;
    token = (json['token'] as String?)!;
    expiresOn = (json['expires_on'] as String?)!;
    expiryMonth = (json['expiry_month'] as int?)!;
    expiryYear = (json['expiry_year'] as int?)!;
    scheme = json['scheme'] as String?;
    last4 = (json['last4'] as String?)!;
    bin = (json['bin'] as String?)!;
    cardType = json['card_type'] as String?;
    cardCategory = json['card_category'] as String?;
    issuer = json['issuer'] as String?;
    issuerCountry = json['issuer_country'] as String?;
    productId = json['product_id'] as String?;
    productType = json['product_type'] as String?;
    billingAddress = (json['billing_address'] as Map<String, dynamic>?) != null
        ? BillingAddress.fromJson(
            json['billing_address'] as Map<String, dynamic>)
        : null;
    phone = (json['phone'] as Map<String, dynamic>?) != null
        ? Phone.fromJson(json['phone'] as Map<String, dynamic>)
        : null;
    name = json['name'] as String?;
  }
}

class WalletsTokenizationResponse {
  late String type;
  late String token;
  late String expiresOn;
  late int expiryMonth;
  late int expiryYear;
  String? scheme;
  late String last4;
  late String bin;
  String? cardType;
  String? cardCategory;
  String? issuer;
  String? issuerCountry;
  String? productId;
  String? productType;

  WalletsTokenizationResponse({
    required this.type,
    required this.token,
    required this.expiresOn,
    required this.expiryMonth,
    required this.expiryYear,
    this.scheme,
    required this.last4,
    required this.bin,
    this.cardType,
    this.cardCategory,
    this.issuer,
    this.issuerCountry,
    this.productId,
    this.productType,
  });

  WalletsTokenizationResponse.fromJson(Map<String, dynamic> json) {
    type = (json['type'] as String?)!;
    token = (json['token'] as String?)!;
    expiresOn = (json['expires_on'] as String?)!;
    expiryMonth = (json['expiry_month'] as int?)!;
    expiryYear = (json['expiry_year'] as int?)!;
    scheme = json['scheme'] as String?;
    last4 = (json['last4'] as String?)!;
    bin = (json['bin'] as String?)!;
    cardType = json['card_type'] as String?;
    cardCategory = json['card_category'] as String?;
    issuer = json['issuer'] as String?;
    issuerCountry = json['issuer_country'] as String?;
    productId = json['product_id'] as String?;
    productType = json['product_type'] as String?;
  }
}
