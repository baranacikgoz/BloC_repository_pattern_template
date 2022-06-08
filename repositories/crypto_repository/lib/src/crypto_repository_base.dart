import 'dart:developer';
import 'dart:io';

import 'package:crypto_repository/crypto_repository.dart';
import 'package:http/http.dart' as http;

class BinanceApiException implements Exception {
  final String message;

  BinanceApiException({
    required this.message,
  });

  factory BinanceApiException.fromCode(int code) {
    log("ERROR CODE: $code");

    if (code == 403) {
      return BinanceApiException(
          message: "WAF Limit (Web Application Firewall) has been violated");
    } else if (code == 400) {
      return BinanceApiException(message: "Malformed request");
    } else if (code == 429) {
      return BinanceApiException(
          message:
              "Request limit is exceeded, if you continue requesting, this IP will be auto-banned by Binance.");
    } else if (code == 418) {
      return BinanceApiException(message: "This IP is auto-banned by Binance");
    } else if (code >= 500 && code <= 599) {
      return BinanceApiException(message: "Binance servers related error.");
    }

    return BinanceApiException(message: "Binance Unknown exception");
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

  static const bitcoin = 'BTC';

  static const usdt = 'USDT';

  Future<CryptoModel> cryptoPairMomentaryData(String coin1, String coin2) async {
    final rawJsonBody = await _cryptoPairMomentaryData(coin1, coin2);

    final CryptoModel pair = CryptoModel.fromJson(rawJsonBody);

    return pair;
  }

  Future<String> _cryptoPairMomentaryData(String coin1, String coin2) async {
    final http.Response response = await http.get(
        Uri.parse("$_binanceBaseApiUrl/ticker/price?$coin1$coin2"),
        headers: _headers);

    if (response.statusCode == 200) {
      return response.body;
    }

    log("BODY: ${response.body} ");
    log("STATUS CODE: ${response.statusCode}");
    throw BinanceApiException.fromCode(response.statusCode);
  }
}
