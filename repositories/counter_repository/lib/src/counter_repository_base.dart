class CounterRepository {
  CounterRepository._();

  // Singleton pattern
  static final instance = CounterRepository._();

  // Take a value, increment it.
  int increment({required int valueToIncrement, required int incrementBy}) {
    // Return incremented value.
    return valueToIncrement + incrementBy;
  }

  // Take a value, decrement it.
  int decrement({required int valueToDecrement, required int decrementBy}) {
    // Return incremented value.
    return valueToDecrement - decrementBy;
  }
}
