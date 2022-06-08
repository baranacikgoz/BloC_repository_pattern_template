import 'package:bloc/bloc.dart';
import 'package:crypto_repository/crypto_repository.dart';
import 'package:meta/meta.dart';

part 'crypto_pair_state.dart';

class CryptoPairCubit extends Cubit<CryptoPairState> {
  final CryptoRepository _cryptoRepository;

  final String _coin1;
  final String _coin2;

  CryptoPairCubit(
      CryptoPairState initialState, this._cryptoRepository, this._coin1, this._coin2)
      : super(initialState);
}
