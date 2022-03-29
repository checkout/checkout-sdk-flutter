import 'dart:convert';

import 'package:checkout_sdk_flutter/src/resources/exceptions.dart';
import 'package:checkout_sdk_flutter/src/resources/requests.dart';
import 'package:checkout_sdk_flutter/src/resources/responses.dart';
import 'package:http/http.dart' as http;

/// [Checkout] is the Class that gives access the the different tokenization options
/// using the Checkout.com API
///
/// Once you create an instance of this class, you can use it like this:
///
///     var cko = new Checkout(publicKey: "your_public_key_here");
///     var res = await cko.tokenizeCard(request);
///     var res = await cko.tokenizeApplePay(request);
///     var res = await cko.tokenizeGooglePay(request);
class Checkout {
  /// The public key associated with your Checkout.com account.
  String publicKey;

  /// The base url for the sandbox API
  static final SANDBOX_BASE_URL = "https://api.sandbox.checkout.com";

  /// The base url for the live API
  static final LIVE_BASE_URL = "https://api.checkout.com";

  /// The regex for the live MBC key
  static final MBC_LIVE_PUBLIC_KEY_REGEX =
      RegExp(r"^pk_?(\w{8})-(\w{4})-(\w{4})-(\w{4})-(\w{12})$");

  /// The regex for the live NAS key
  static final NAS_LIVE_PUBLIC_KEY_REGEX =
      new RegExp(r"^pk_?[a-z2-7]{26}[a-z2-7*#$=]$");

  /// Determines the API URL to use for the environment the the key  belongs to
  static String getEnvironment(String key) {
    if (MBC_LIVE_PUBLIC_KEY_REGEX.hasMatch(key) ||
        NAS_LIVE_PUBLIC_KEY_REGEX.hasMatch(key)) {
      return LIVE_BASE_URL;
    } else {
      return SANDBOX_BASE_URL;
    }
  }

  /// A public key is required to initialize the SDK
  Checkout({required this.publicKey});

  /// Tokenize card details
  ///
  /// Can throw  [InvalidDataError]  if the data provided is not correct,
  /// or [UnauthorizedError] in case there is an issue with the api authentication
  /// or a general [Exception].
  /// Returns the tokenization response including the card token used to process
  /// a payment from the server side.
  Future<CardTokenizationResponse> tokenizeCard(
      CardTokenizationRequest request) async {
    CardTokenizationRequest data = request;
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse(getEnvironment(publicKey) + '/tokens');

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": publicKey
        },
        body: body);

    if (response.statusCode == 401) throw new UnauthorizedError();

    if (response.statusCode == 422)
      throw new InvalidDataError.fromJson(jsonDecode(response.body));

    if ((response.statusCode ~/ 100) == 2) {
      return CardTokenizationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response);
    }
  }

  /// Tokenize apple pay payload
  ///
  /// Can throw  [InvalidDataError]  if the data provided is not correct,
  /// or [UnauthorizedError] in case there is an issue with the api authentication
  /// or a general [Exception].
  /// Returns the tokenization response including the card token used to process
  /// a payment from the server side.
  Future<WalletsTokenizationResponse> tokenizeApplePay(
      ApplePayTokenizationRequest request) async {
    ApplePayTokenizationRequest data = request;
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse(getEnvironment(publicKey) + '/tokens');

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": publicKey
        },
        body: body);

    if (response.statusCode == 401) throw new UnauthorizedError();

    if (response.statusCode == 422)
      throw new InvalidDataError.fromJson(jsonDecode(response.body));

    if ((response.statusCode ~/ 100) == 2) {
      return WalletsTokenizationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response);
    }
  }

  /// Tokenize google pay payload
  ///
  /// Can throw  [InvalidDataError]  if the data provided is not correct,
  /// or [UnauthorizedError] in case there is an issue with the api authentication
  /// or a general [Exception].
  /// Returns the tokenization response including the card token used to process
  /// a payment from the server side.
  Future<WalletsTokenizationResponse> tokenizeGooglePay(
      GooglePayTokenizationRequest request) async {
    GooglePayTokenizationRequest data = request;
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse(getEnvironment(publicKey) + '/tokens');

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": publicKey
        },
        body: body);

    if (response.statusCode == 401) throw new UnauthorizedError();

    if (response.statusCode == 422)
      throw new InvalidDataError.fromJson(jsonDecode(response.body));

    if ((response.statusCode ~/ 100) == 2) {
      return WalletsTokenizationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response);
    }
  }
}
