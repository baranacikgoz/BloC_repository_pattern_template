/// Base class for screen args.
abstract class ScreenArgs {}

/// Second screen args.
class SecondScreenArgs extends ScreenArgs {
  /// Constructor
  SecondScreenArgs({
    required this.counterValue,
  });

  /// Counter value passed.
  final int counterValue;
}
