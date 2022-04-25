import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/constants/strings.dart';

part 'internet_connectivity_state.dart';

class InternetConnectivityCubit extends Cubit<InternetConnectivityState> {
  late final StreamSubscription internetStatusSubscription;

  InternetConnectivityCubit()
      : super(ConnectivityResultState(
            connectivityResult: Strings.noInternetConnection)) {
    _monitorInternetStatus();
  }

  _monitorInternetStatus() {
    return internetStatusSubscription =
        Connectivity().onConnectivityChanged.listen((status) {
      //! Emit status
      _deserializeAndEmit(status);
    });
  }

  void _deserializeAndEmit(ConnectivityResult _status) {
    switch (_status) {
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.wifi:
        _emitConnectivityResult(Strings.connectedWithWifi);
        break;
      case ConnectivityResult.ethernet:
        _emitConnectivityResult(Strings.connectedWithEthernet);
        break;
      case ConnectivityResult.mobile:
        _emitConnectivityResult(Strings.connectedWithCellular);
        break;
      case ConnectivityResult.none:
        _emitConnectivityResult(Strings.noInternetConnection);
        break;
    }
  }

  void _emitConnectivityResult(String _result) {
    emit(ConnectivityResultState(connectivityResult: _result));
  }

  @override
  Future<void> close() {
    internetStatusSubscription.cancel();
    return super.close();
  }
}
