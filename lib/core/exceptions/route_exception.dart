/// Route exception class.
class RouteException implements Exception {
  /// Constructor.
  const RouteException({required this.message});

  /// Exception message
  final String message;
}
