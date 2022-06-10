import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_template/core/constants/strings.dart';
import 'package:meta/meta.dart';

part 'internet_connectivity_state.dart';

/// Internet connectivitiy cubit will track connection state.
class InternetConnectivityCubit extends Cubit<InternetConnectivityState> {
  /// Constructor.
  InternetConnectivityCubit()
      : super(
          ConnectivityResultState(connectivityResult: Strings.noInternetConnectionText),
        ) {
    _monitorInternetStatus();
  }

  late final StreamSubscription<ConnectivityResult> _internetStatusSubscription;

  StreamSubscription<ConnectivityResult> _monitorInternetStatus() {
    return _internetStatusSubscription =
        Connectivity().onConnectivityChanged.listen(_deserializeAndEmit);
  }

  void _deserializeAndEmit(ConnectivityResult _status) {
    switch (_status) {
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.wifi:
        _emitConnectivityResult(Strings.connectedWithWifiText);
        break;
      case ConnectivityResult.ethernet:
        _emitConnectivityResult(Strings.connectedWithEthernetText);
        break;
      case ConnectivityResult.mobile:
        _emitConnectivityResult(Strings.connectedWithCellularText);
        break;
      case ConnectivityResult.none:
        _emitConnectivityResult(Strings.noInternetConnectionText);
        break;
    }
  }

  void _emitConnectivityResult(String _result) {
    emit(ConnectivityResultState(connectivityResult: _result));
  }

  @override
  Future<void> close() {
    _internetStatusSubscription.cancel();
    return super.close();
  }
}
