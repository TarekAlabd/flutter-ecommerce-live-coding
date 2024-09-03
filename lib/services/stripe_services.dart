import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeServices {
  StripeServices._();

  static final StripeServices instance = StripeServices._();

  Future<void> makePayment(double amount, String currency) async {
    try {
      final clientSecret = await _createPaymentIntent(amount, currency);
      if (clientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'E-commerce Live Coding by Tarek',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      debugPrint('Make Payment: ${e.toString()}');
      rethrow;
    }
  }

  Future<String?> _createPaymentIntent(double amount, String currency) async {
    try {
      final aDio = Dio();
      Map<String, dynamic> body = {
        'amount': _getFinalAmount(amount),
        'currency': currency,
      };

      final headers = {
        'Authorization': 'Bearer ${AppConstants.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      final response = await aDio.post(
        AppConstants.paymentIntentPath,
        data: body,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: headers,
        ),
      );
      if (response.data != null) {
        debugPrint(response.data.toString());
        return response.data['client_secret'];
      }
    } catch (e) {
      debugPrint('Create Payment Intent: ${e.toString()}');
      rethrow;
    }
    return null;
  }

  int _getFinalAmount(double amount) {
    return (amount * 100).toInt();
  }
}
