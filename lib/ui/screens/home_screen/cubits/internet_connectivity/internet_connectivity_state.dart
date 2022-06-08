part of 'internet_connectivity_cubit.dart';

@immutable
abstract class InternetConnectivityState {}

class ConnectivityResultState extends InternetConnectivityState {
  final String connectivityResult;

  ConnectivityResultState({
    required this.connectivityResult,
  });
}
