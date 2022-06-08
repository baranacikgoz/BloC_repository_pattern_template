import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:crypto_repository/crypto_repository.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository _cryptoRepository;

  double _currentPrice = 0;

  CryptoBloc(this._cryptoRepository) : super(CryptoInitial()) {
    on<CryptoEvent>(_onRefreshRequest);
  }

  Future<void> _onRefreshRequest(CryptoEvent event, Emitter<CryptoState> emit) async {
    try {
      final data = await _cryptoRepository.btcUsdtMomentaryData();

      final newPrice = data.price;

      final isIncreased = newPrice > _currentPrice ? true : false;

      _currentPrice = newPrice;

      emit(ReceivedCryptoData(isIncreased: isIncreased, cryptoData: data));
    } catch (e) {
      emit(ErrorCryptoData(message: e.toString()));
    }
  }
}
