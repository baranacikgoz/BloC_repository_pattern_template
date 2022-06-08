part of 'crypto_bloc.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();

  @override
  List<Object> get props => [];
}

class CryptoInitial extends CryptoState {}

class FetchingCryptoData extends CryptoState {}

class ReceivedCryptoData extends CryptoState {
  final bool isIncreased;
  final CryptoModel cryptoData;

  const ReceivedCryptoData({required this.isIncreased, required this.cryptoData});
}

class ErrorCryptoData extends CryptoState {
  final String message;

  const ErrorCryptoData({required this.message});
}
