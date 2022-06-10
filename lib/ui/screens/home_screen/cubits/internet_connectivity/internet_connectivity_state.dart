part of 'internet_connectivity_cubit.dart';

/// Base class for internet connectivitiy state.
@immutable
abstract class InternetConnectivityState {}

/// Connectivity Result State class.
class ConnectivityResultState extends InternetConnectivityState {
  /// Constructor.
  ConnectivityResultState({
    required this.connectivityResult,
  });

  /// The connectivity result.
  final String connectivityResult;
}
