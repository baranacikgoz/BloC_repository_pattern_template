import 'package:flutter_project_template/repositories/counter_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

//! Hydrated cubit will store counter's last value therefore it will remain
//! the same when you closed and re-open app.
class CounterCubit extends HydratedCubit<int> {
  final CounterRepository _counterRepository;

  CounterCubit(this._counterRepository) : super(0);

  //! increase _currentValue by 1 and emit new value
  void onIncrement() {
    int currentValue =
        _counterRepository.increment(valueToIncrement: state, incrementBy: 1);

    emit(currentValue);
  }

  //! decrement counter by 1 and emit new value
  void onDecrement() {
    int currentValue =
        _counterRepository.decrement(valueToDecrement: state, decrementBy: 1);

    emit(currentValue);
  }

  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};
}
