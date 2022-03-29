# Checkout SKD for Flutter

> :warning: **This SDK is in the Public Beta phase.** 

A Flutter plugin that wraps the Checkout.com's [tokenization API](https://api-reference.checkout.com/#operation/requestAToken) in order to allow the tokenization for
card details as well as Apple Pay and Google Pay payloads.

## Installation

Add checkout_sdk_flutter to your `pubspec.yaml` file:

```yaml
dependencies:
  ...
  checkout_sdk_flutter: <version>
```

## Usage

If our team did not create an account for you already, you can create one [here](https://www.checkout.com/get-test-account).
Once you have an account you should have access to your public API key.

Import the plugin in your code:

```dart
import 'package:johnnysdk_flutter/checkout_sdk_flutter.dart';
```

Initialize the SDK with your public key:

```dart
var cko = new Checkout(publicKey: "your_key");
```

> Note that the SDK will automatically determine what environment to use based on the key you provide.

#### Tokenize a card

```dart
final request = CardTokenizationRequest(
    number: "4242424242424242",
    expiryMonth: 11,
    expiryYear: 2029,
    cvv: "100",
    name: "John Smith");
var res = await cko.tokenizeCard(request);
```

#### Tokenize an ApplePay payload

```dart
final request = ApplePayTokenizationRequest(
tokenData: AppleTokenData(
    version: 'EC_v1',
    data: 'XXXXXX',
    signature: 'XXXXXX',
    header: AppleHeader(
        ephemeralPublicKey: 'XXXXXX',
        publicKeyHash: 'XXXXXX',
        transactionId: 'XXXXXX')),
);

var res = await cko.tokenizeApplePay(request);
```

#### Tokenize a GooglePay payload

```dart
final request = GooglePayTokenizationRequest(
tokenData: GoogleTokenData(
    signature: 'XXX', protocolVersion: 'XXX', signedMessage: "XXX"),
);

var res = await cko.tokenizeGooglePay(request);
```

#### Handle exemptions

```dart
try {
  // sdk action
} on UnauthorizedError catch (exception) {
 // handle UnauthorizedError
} on InvalidDataError catch (exception) {
 // handle InvalidDataError
} catch (error) {
 // handle any other exemptions
}
```
