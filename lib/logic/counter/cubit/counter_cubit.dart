import 'package:flutter_project_template/repositories/counter_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

//! Hydrated cubit will store counter's last value therefore it will remain
//! the same when you closed and re-open app.
class CounterCubit extends HydratedCubit<int> {
  final CounterRepository _counterRepository;

  // Current value
  late int _currentValue;

  CounterCubit(this._counterRepository) : super(0) {
    // Initialize current value
    _currentValue = state;
  }

  //! increase _currentValue by 1 and emit new value
  void onIncrement() {
    _counterRepository.increment(valueToIncrement: _currentValue, incrementBy: 1);

    emit(_currentValue);
  }

  //! decrement counter by 1 and emit new value
  void onDecrement() {
    _counterRepository.increment(valueToIncrement: _currentValue, incrementBy: 1);

    emit(_currentValue);
  }

  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};
}
