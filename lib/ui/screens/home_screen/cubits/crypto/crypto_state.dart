part of 'crypto_cubit.dart';

/// Base class for crypto states
abstract class CryptoState extends Equatable {}

/// Initial state
class CryptoInitial extends CryptoState {
  @override
  List<Object?> get props => [];
}

/// This state is emited while data is fetching
class FetchingCryptoData extends CryptoState {
  @override
  List<Object?> get props => [];
}

/// This state is emited when data is received.
class ReceivedCryptoData extends CryptoState {
  /// Constructor.
  ReceivedCryptoData({required this.isIncreased, required this.cryptoData});

  /// Tells the ui whether price is increased or decreased.
  final bool isIncreased;

  /// Data
  final CryptoModel cryptoData;

  @override
  List<Object?> get props => [cryptoData];
}

/// This state is emited if an error occurs
class ErrorCryptoData extends CryptoState {
  /// Constructor.
  ErrorCryptoData({required this.message});

  /// Error message
  final String message;

  @override
  List<Object?> get props => [message];
}
