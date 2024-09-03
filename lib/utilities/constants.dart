String documentIdFromLocalData() => DateTime.now().toIso8601String();

class AppConstants {
  static const String paymentIntentPath =
      'https://api.stripe.com/v1/payment_intents';

  /// Stripe Keys
  static const String publishableKey =
      'pk_test_51PPo8hRoXZnvJgvhmlmpg1Lfyg5cqkwG28eNHEdJHazS5y9vVvgK9vRMZA0ABR79ZBgLxLMkCoUuMXsNU760dHST0074OEqGCn';
  static const String secretKey =
      'sk_test_51PPo8hRoXZnvJgvhEDx2v6s8LjltgvUsOLqnxSufQa4opacp3bmHckSAI6dU9iAAca9icN3BlavcqwJxTrRgaP7C00u2Ow7wsN';
}
