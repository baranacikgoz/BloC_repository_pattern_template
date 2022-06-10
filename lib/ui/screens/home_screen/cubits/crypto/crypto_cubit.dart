import 'package:bloc/bloc.dart';
import 'package:crypto_repository/crypto_repository.dart';
import 'package:equatable/equatable.dart';

part 'crypto_state.dart';

/// Crypto cubit.
class CryptoCubit extends Cubit<CryptoState> {
  /// constructor takes crypto repository as argument.
  CryptoCubit(this._cryptoRepository) : super(CryptoInitial());

  final CryptoRepository _cryptoRepository;

  double _currentPrice = 0;

  /// Makes a price refresh request
  Future<void> onRefreshRequest() async {
    emit(FetchingCryptoData());

    try {
      final cryptoData = await _cryptoRepository.btcUsdtMomentaryData();

      // ignore: avoid_bool_literals_in_conditional_expressions
      final _isIncreased = cryptoData.price > _currentPrice ? true : false;

      emit(
        ReceivedCryptoData(isIncreased: _isIncreased, cryptoData: cryptoData),
      );

      _currentPrice = cryptoData.price;
    } catch (e) {
      emit(ErrorCryptoData(message: e.toString()));
    }
  }
}
