import 'dart:developer';
import 'dart:io';

import 'package:crypto_repository/crypto_repository.dart';
import 'package:http/http.dart' as http;

/// Exceptions
class BinanceApiException implements Exception {
  /// Constructor.
  BinanceApiException({
    required this.message,
  });

  /// Generates exception from status code.
  factory BinanceApiException.fromCode(int statusCode) {
    log('Status code: $statusCode');

    if (statusCode == 403) {
      return BinanceApiException(
        message: 'WAF Limit (Web Application Firewall) has been violated',
      );
    } else if (statusCode == 400) {
      return BinanceApiException(message: 'Malformed request');
    } else if (statusCode == 429) {
      return BinanceApiException(
        message: 'Request limit is exceeded, if you continue requesting, '
            'this IP will be auto-banned by Binance.',
      );
    } else if (statusCode == 418) {
      return BinanceApiException(message: 'This IP is auto-banned by Binance');
    } else if (statusCode >= 500 && statusCode <= 599) {
      return BinanceApiException(message: 'Binance servers related error.');
    }

    return BinanceApiException(message: 'Binance Unknown exception');
  }

  /// Error message
  final String message;

  @override
  String toString() {
    return message;
  }
}

/// Crypto repository.
class CryptoRepository {
  /// Singleton pattern
  CryptoRepository._();

  /// Singleton instance
  static final instance = CryptoRepository._();

  static const String _binanceBaseApiUrl = 'https://api.binance.com/api/v3';

  static const String _apiKey = 'YOUR API KEY HERE';
  static const String _apiSecretKey = 'YOUR SECRET API KEY HERE';

  static const Map<String, String> _headers = {
    'binance-api-key': _apiKey,
    'binance-api-secret': _apiSecretKey,
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  /// Get btc/usdt momentary price
  Future<CryptoModel> btcUsdtMomentaryData() async {
    final rawJsonBody = await _btcUsdtMomentaryData();

    final pair = CryptoModel.fromJson(rawJsonBody);

    return pair;
  }

  Future<String> _btcUsdtMomentaryData() async {
    final response = await http.get(
      Uri.parse('$_binanceBaseApiUrl/ticker/price?symbol=BTCUSDT'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    log('BODY: ${response.body} ');
    throw BinanceApiException.fromCode(response.statusCode);
  }
}
