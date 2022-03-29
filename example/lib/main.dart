import 'dart:developer';

import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:flutter/material.dart';

import 'package:credit_card_input_form/credit_card_input_form.dart';
import 'package:checkout_sdk_flutter/checkout_sdk_flutter.dart';
import 'package:alert/alert.dart';

var cko =
    new Checkout(publicKey: "pk_test_4296fd52-efba-4a38-b6ce-cf0d93639d8a");

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: Stack(children: [
              CreditCardInputForm(
                showResetButton: true,
                onStateChange: (currentState, cardInfo) async {
                  if (currentState == InputState.DONE) {
                    // Checkout.com SDK
                    try {
                      final request = CardTokenizationRequest(
                          number: cardInfo.cardNumber.replaceAll(' ', ''),
                          expiryMonth:
                              int.parse(cardInfo.validate.substring(0, 2)),
                          expiryYear: 2000 +
                              int.parse(cardInfo.validate.substring(3, 5)),
                          cvv: cardInfo.cvv,
                          name: cardInfo.name);
                      var res = await cko.tokenizeCard(request);
                      Alert(message: res.token).show();
                    } on UnauthorizedError catch (exception) {
                      print('UnauthorizedError data:');
                    } on InvalidDataError catch (exception) {
                      print('InvalidDataError data');
                    } catch (error) {
                      print(error);
                    }
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
