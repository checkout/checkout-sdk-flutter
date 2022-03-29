import 'dart:developer';
import 'package:flutter_test/flutter_test.dart';
import 'package:checkout_sdk_flutter/checkout_sdk_flutter.dart';

var PK = "pk_test_4296fd52-efba-4a38-b6ce-cf0d93639d8a";

void main() {
  group('Card Tokenization', () {
    test('card details should be tokenized', () async {
      var cko = new Checkout(publicKey: PK);

      final request = CardTokenizationRequest(
          type: "card",
          number: "4242424242424242",
          expiryMonth: 6,
          expiryYear: 2028,
          billingAddress: BillingAddress(
            addressLine1: "Checkout.com",
            addressLine2: "90 Tottenham Court Road",
            city: "London",
            state: "London",
            zip: "W1T 4TJ",
            country: "GB",
          ),
          phone: Phone(
            number: "7432534231",
            countryCode: "+44",
          ));

      var res = await cko.tokenizeCard(request);

      expect(res.bin, "424242");
      expect(res.expiryYear, 2028);
      expect(res.billingAddress!.addressLine1, "Checkout.com");
      expect(res, isA<CardTokenizationResponse>());
    });

    test('should throw invalid data request', () async {
      try {
        var cko = new Checkout(publicKey: PK);

        final request = CardTokenizationRequest(
          type: "card",
          number: "42424242",
          expiryMonth: 6,
          expiryYear: 2028,
        );

        var res = await cko.tokenizeCard(request);
      } catch (e) {
        expect(e, isA<InvalidDataError>());
      }
    });

    test('should throw authentication error', () async {
      try {
        var cko = new Checkout(publicKey: "abc");

        final request = CardTokenizationRequest(
          type: "card",
          number: "42424242",
          expiryMonth: 6,
          expiryYear: 2028,
        );

        var res = await cko.tokenizeCard(request);
      } catch (e) {
        expect(e, isA<UnauthorizedError>());
      }
    });

    test('should determine sb environment mbc', () async {
      var env = Checkout.getEnvironment(
          "pk_test_4296fd52-efba-4a38-b6ce-cf0d93639d8a");
      expect(env, "https://api.sandbox.checkout.com");
    });

    test('should determine live environment mbc', () async {
      var env =
          Checkout.getEnvironment("pk_4296fd52-efba-4a38-b6ce-cf0d93639d8a");
      expect(env, "https://api.checkout.com");
    });

    test('should determine sb environment nas', () async {
      var env = Checkout.getEnvironment("pk_sbox_xg66bnn6tpspd6pt3psc7otrqa=");
      expect(env, "https://api.sandbox.checkout.com");
    });

    test('should determine live environment nas', () async {
      var env = Checkout.getEnvironment("pk_xg66bnn6tpspd6pt3psc7otrqa=");
      expect(env, "https://api.checkout.com");
    });
  });

  group('ApplePay Tokenization', () {
    test('apple pay payload should be tokenized', () async {
      var cko = new Checkout(
          publicKey: "pk_test_6e40a700-d563-43cd-89d0-f9bb17d35e73");

      final request = ApplePayTokenizationRequest(
        tokenData: AppleTokenData(
            version: 'EC_v1',
            data:
                'cWjjsdADd0e6O2cba0cpF1458RnoR0DAxvP/lfwBPz/HfcfBQY8Wld/m+k8WjBpwn504khNVFuJ3pGdZwUHUGVv5PrujtiglkCH3B+uMDYSzalfCi6/wQf0zDmHJVoghZb0dDz4Xrh4NicTYqcmTBzPRSEcisDxxbyzH8nD2jsd/bBA2Q+jzCGhWcV/gKKjLY2XQOEc0RpHyVAKtanGSfCpCZQPQ6D/19nzvWQe9kuqfLPqmB+gBi6Z7eYMhgdLKUZpXd/m3TL3AjrOeZxvoUr++VEI+XqRqDJT5GH+cmKRlR4/ezM9y4fwdO6DJUmh8kx1iWh0CFO38KmPM+dEcL7vKS2UkIyw4FExt4LLtgGBF2P6xu7JWUyRGnLYXRfZxpd0VpgGqCqLcDRn1',
            signature:
                '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',
            header: AppleHeader(
                ephemeralPublicKey:
                    'MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEcadkxKiD26rU6v7m2g6EyJCjTPzHLtiekGrVxrR7MKYzI3w5L0Kn2EnAt81t3E1IpDkZCdY81CCVu5WO143G2w==',
                publicKeyHash: '0KORSnwFZImfHyE1SuzhDaMMOMBia+SKBZPRuTzTCUc=',
                transactionId:
                    '0d6788b178d15c6fa2d076c2a7d61bf8897722fa96d2d711ad2c4f617e9b0c70')),
      );

      var res = await cko.tokenizeApplePay(request);

      expect(res.bin, "520424");
    });

    test('should throw invalid data request', () async {
      try {
        var cko = new Checkout(
            publicKey: "pk_test_6e40a700-d563-43cd-89d0-f9bb17d35e73");

        final request = ApplePayTokenizationRequest(
          tokenData: AppleTokenData(
              version: 'EC_v1',
              data: '123456',
              signature: '123456',
              header: AppleHeader(
                  ephemeralPublicKey:
                      'MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEcadkxKiD26rU6v7m2g6EyJCjTPzHLtiekGrVxrR7MKYzI3w5L0Kn2EnAt81t3E1IpDkZCdY81CCVu5WO143G2w==',
                  publicKeyHash: '0KORSnwFZImfHyE1SuzhDaMMOMBia+SKBZPRuTzTCUc=',
                  transactionId: '123456')),
        );
      } catch (e) {
        expect(e, isA<InvalidDataError>());
      }
    });

    test('should throw authentication error', () async {
      try {
        var cko = new Checkout(publicKey: "abc");

        final request = ApplePayTokenizationRequest(
          tokenData: AppleTokenData(
              version: 'EC_v1',
              data:
                  'cWjjsdADd0e6O2cba0cpF1458RnoR0DAxvP/lfwBPz/HfcfBQY8Wld/m+k8WjBpwn504khNVFuJ3pGdZwUHUGVv5PrujtiglkCH3B+uMDYSzalfCi6/wQf0zDmHJVoghZb0dDz4Xrh4NicTYqcmTBzPRSEcisDxxbyzH8nD2jsd/bBA2Q+jzCGhWcV/gKKjLY2XQOEc0RpHyVAKtanGSfCpCZQPQ6D/19nzvWQe9kuqfLPqmB+gBi6Z7eYMhgdLKUZpXd/m3TL3AjrOeZxvoUr++VEI+XqRqDJT5GH+cmKRlR4/ezM9y4fwdO6DJUmh8kx1iWh0CFO38KmPM+dEcL7vKS2UkIyw4FExt4LLtgGBF2P6xu7JWUyRGnLYXRfZxpd0VpgGqCqLcDRn1',
              signature:
                  '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',
              header: AppleHeader(
                  ephemeralPublicKey:
                      'MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEcadkxKiD26rU6v7m2g6EyJCjTPzHLtiekGrVxrR7MKYzI3w5L0Kn2EnAt81t3E1IpDkZCdY81CCVu5WO143G2w==',
                  publicKeyHash: '0KORSnwFZImfHyE1SuzhDaMMOMBia+SKBZPRuTzTCUc=',
                  transactionId:
                      '0d6788b178d15c6fa2d076c2a7d61bf8897722fa96d2d711ad2c4f617e9b0c70')),
        );

        var res = await cko.tokenizeApplePay(request);
      } catch (e) {
        expect(e, isA<UnauthorizedError>());
      }
    });
  });

  group('GooglePay Tokenization', () {
    test('google pay payload should be tokenized', () async {
      var cko = new Checkout(publicKey: PK);

      final request = GooglePayTokenizationRequest(
        tokenData: GoogleTokenData(
            signature:
                'MEUCIQCFcrfaWA5r23zytrt1Nl8K6GLGkIXwPs0nnqBzijn6bwIgHrs+4DqSOsBhsSse6+dy3zPry8ybmJ7qrC+HTucgc6o=',
            protocolVersion: 'ECv1',
            signedMessage:
                "{\"encryptedMessage\":\"8T2j1NZrEgg2+/WBx0ZAZow2nn/yLa0jh6uoFTCax3G/IF70rs3o6bKmGkM59l35//lDYEYyY+FO3Yc+GkAnR1q1K4ZO6FBtCbMPz3lTQemNmM4f4ohk2ROdxfW2Gmgp4nULXF/YBl3C2tSnRZXvaekJc5aipEgbzCQZkVa9FDMZVTXKrs67KMNI0B4VQcS+6pjcx5kd32+TSvqfQBqp6banxKT8oOegSSNSCZl8ucIQLAuMNbcypVOUTDRWUKZqJQ3CB9Au+j+CZifDeFCoojmQQ8q9udo3Ql3RA36F80+3l8IOtc6B3NLut/1kzMEujqcmyZTEeFgNdtFrcS3yxLgI9jJjVn8J4tUlZuL8FSkhXEwvaBvpdAQ6Yvvb2gC4J2oNGqpA65Sfm+3uaFUJ3HOgPDv098uaykFn3xSugzZx6Imvd+dchSI4X1yhd0OMudW1kk6dbhpqMsgPhdxW1cEppNaQmO1GfnC6JLXnSXKvvJadcn3e\",\"ephemeralPublicKey\":\"BCp1zFJicbfrP8xCh1wmByPSvN0kaODqz0uALxF95F3UO3qcMtK970ovrZWHHTI6kUmrwgtpDJjn9F9bV9SUeWs\\u003d\",\"tag\":\"EpKSZsCLXWN0OC5Xjw9w0V9eFiIjpruy/2+t4KQqGp0\\u003d\"}"),
      );

      var res = await cko.tokenizeGooglePay(request);

      expect(res.bin, "411111");
    });

    test('should throw invalid data request', () async {
      try {
        var cko = new Checkout(publicKey: PK);

        final request = GooglePayTokenizationRequest(
          tokenData: GoogleTokenData(
              signature: '1234',
              protocolVersion: 'ECv1',
              signedMessage: "1234"),
        );

        var res = await cko.tokenizeGooglePay(request);
      } catch (e) {
        expect(e, isA<InvalidDataError>());
      }
    });

    test('should throw authentication error', () async {
      try {
        var cko = new Checkout(publicKey: "abc");

        final request = GooglePayTokenizationRequest(
          tokenData: GoogleTokenData(
              signature:
                  'MEUCIQCFcrfaWA5r23zytrt1Nl8K6GLGkIXwPs0nnqBzijn6bwIgHrs+4DqSOsBhsSse6+dy3zPry8ybmJ7qrC+HTucgc6o=',
              protocolVersion: 'ECv1',
              signedMessage:
                  "{\"encryptedMessage\":\"8T2j1NZrEgg2+/WBx0ZAZow2nn/yLa0jh6uoFTCax3G/IF70rs3o6bKmGkM59l35//lDYEYyY+FO3Yc+GkAnR1q1K4ZO6FBtCbMPz3lTQemNmM4f4ohk2ROdxfW2Gmgp4nULXF/YBl3C2tSnRZXvaekJc5aipEgbzCQZkVa9FDMZVTXKrs67KMNI0B4VQcS+6pjcx5kd32+TSvqfQBqp6banxKT8oOegSSNSCZl8ucIQLAuMNbcypVOUTDRWUKZqJQ3CB9Au+j+CZifDeFCoojmQQ8q9udo3Ql3RA36F80+3l8IOtc6B3NLut/1kzMEujqcmyZTEeFgNdtFrcS3yxLgI9jJjVn8J4tUlZuL8FSkhXEwvaBvpdAQ6Yvvb2gC4J2oNGqpA65Sfm+3uaFUJ3HOgPDv098uaykFn3xSugzZx6Imvd+dchSI4X1yhd0OMudW1kk6dbhpqMsgPhdxW1cEppNaQmO1GfnC6JLXnSXKvvJadcn3e\",\"ephemeralPublicKey\":\"BCp1zFJicbfrP8xCh1wmByPSvN0kaODqz0uALxF95F3UO3qcMtK970ovrZWHHTI6kUmrwgtpDJjn9F9bV9SUeWs\\u003d\",\"tag\":\"EpKSZsCLXWN0OC5Xjw9w0V9eFiIjpruy/2+t4KQqGp0\\u003d\"}"),
        );

        var res = await cko.tokenizeGooglePay(request);
      } catch (e) {
        expect(e, isA<UnauthorizedError>());
      }
    });
  });
}
