import 'package:bloc/bloc.dart';
import 'package:crypto_repository/crypto_repository.dart';
import 'package:equatable/equatable.dart';

part 'crypto_state.dart';

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoRepository _cryptoRepository;

  double _currentPrice = 0;

  CryptoCubit(this._cryptoRepository) : super(CryptoInitial());

  Future<void> onRefreshRequest() async {
    emit(FetchingCryptoData());

    try {
      final cryptoData = await _cryptoRepository.btcUsdtMomentaryData();

      final _isIncreased = cryptoData.price > _currentPrice ? true : false;

      emit(ReceivedCryptoData(isIncreased: _isIncreased, cryptoData: cryptoData));

      _currentPrice = cryptoData.price;
    } catch (e) {
      emit(ErrorCryptoData(message: e.toString()));
    }
  }
}
