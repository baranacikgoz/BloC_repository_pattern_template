import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Data class for crypto data
class CryptoModel extends Equatable {
  /// Constructor.
  const CryptoModel({
    required this.receivedTime,
    required this.price,
  });

  /// Factory constructor.
  factory CryptoModel.fromMap(Map<String, dynamic> map) {
    return CryptoModel(
      receivedTime: DateTime.now(),
      price: double.parse(map['price'] as String),
    );
  }

  /// Factory constructor.
  factory CryptoModel.fromJson(String source) =>
      CryptoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Price.
  final double price;

  /// Received time.
  final DateTime receivedTime;

  @override
  List<Object> get props => [receivedTime, price];
}
