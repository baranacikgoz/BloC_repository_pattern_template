import 'dart:convert';

import 'package:equatable/equatable.dart';

class CryptoModel extends Equatable {
  final String symbol;
  final double price;
  final DateTime receivedTime;

  const CryptoModel._({
    required this.receivedTime,
    required this.symbol,
    required this.price,
  });

  @override
  List<Object> get props => [
        receivedTime,
        // symbol,
        price
      ];

  factory CryptoModel.fromMap(Map<String, dynamic> map) {
    return CryptoModel._(
      receivedTime: DateTime.now(),
      symbol: map['symbol'] ?? '',
      price: double.parse(map['price']),
    );
  }

  factory CryptoModel.fromJson(String source) => CryptoModel.fromMap(json.decode(source));
}
