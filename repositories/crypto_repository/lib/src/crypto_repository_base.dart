import 'dart:developer';
import 'dart:io';

import 'package:crypto_repository/crypto_repository.dart';
import 'package:http/http.dart' as http;

class BinanceApiException implements Exception {
  final String message;

  BinanceApiException({
    required this.message,
  });

  factory BinanceApiException.fromCode(int statusCode) {
    log("Status code: $statusCode");

    if (statusCode == 403) {
      return BinanceApiException(
          message: "WAF Limit (Web Application Firewall) has been violated");
    } else if (statusCode == 400) {
      return BinanceApiException(message: "Malformed request");
    } else if (statusCode == 429) {
      return BinanceApiException(
          message:
              "Request limit is exceeded, if you continue requesting, this IP will be auto-banned by Binance.");
    } else if (statusCode == 418) {
      return BinanceApiException(message: "This IP is auto-banned by Binance");
    } else if (statusCode >= 500 && statusCode <= 599) {
      return BinanceApiException(message: "Binance servers related error.");
    }

    return BinanceApiException(message: "Binance Unknown exception");
  }

  @override
  String toString() {
    return message;
  }
}

class CryptoRepository {
  CryptoRepository._();

  static final instance = CryptoRepository._();

  static const String _binanceBaseApiUrl = 'https://api.binance.com/api/v3';

  static const String _apiKey =
      'WhjSOGCVcy1rDXRCGSzo0fB95rBPuk8nPdk451XqnPLk1PKNbPOkBo4Rjk0xPQHO';
  static const String _apiSecretKey =
      'b61577b6cf53b2cb89203405e4a81cb444d9f1c846bd68fb3e8646d0aa86f7cc';

  static const Map<String, String> _headers = {
    'binance-api-key': _apiKey,
    'binance-api-secret': _apiSecretKey,
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  Future<CryptoModel> btcUsdtMomentaryData() async {
    final rawJsonBody = await _btcUsdtMomentaryData();

    final CryptoModel pair = CryptoModel.fromJson(rawJsonBody);

    return pair;
  }

  Future<String> _btcUsdtMomentaryData() async {
    final http.Response response = await http.get(
        Uri.parse("$_binanceBaseApiUrl/ticker/price?symbol=BTCUSDT"),
        headers: _headers);

    if (response.statusCode == 200) {
      return response.body;
    }

    log("BODY: ${response.body} ");
    throw BinanceApiException.fromCode(response.statusCode);
  }
}
