part of 'crypto_cubit.dart';

abstract class CryptoState extends Equatable {}

class CryptoInitial extends CryptoState {
  @override
  List<Object?> get props => [];
}

class FetchingCryptoData extends CryptoState {
  @override
  List<Object?> get props => [];
}

class ReceivedCryptoData extends CryptoState {
  final bool isIncreased;

  final CryptoModel cryptoData;

  ReceivedCryptoData({required this.isIncreased, required this.cryptoData});

  @override
  List<Object?> get props => [cryptoData];
}

class ErrorCryptoData extends CryptoState {
  final String message;

  ErrorCryptoData({required this.message});

  @override
  List<Object?> get props => [message];
}
