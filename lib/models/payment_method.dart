import 'dart:convert';

class PaymentMethod {
  final String id;
  final String name;
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'cardNumber': cardNumber});
    result.addAll({'expiryDate': expiryDate});
    result.addAll({'cvv': cvv});
  
    return result;
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      cardNumber: map['cardNumber'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      cvv: map['cvv'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) => PaymentMethod.fromMap(json.decode(source));
}
