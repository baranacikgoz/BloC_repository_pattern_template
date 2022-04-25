import 'package:hydrated_bloc/hydrated_bloc.dart';

//! Hydrated cubit will store counter's last value therefore it will remain
//! the same when you closed and re-open app.
class CounterCubit extends HydratedCubit<int> {
  CounterCubit() : super(0);

  void increment() {
    //! increase counter by 1 and emit new value
    _emitCounterValue(state + 1);
  }

  void decrement() {
    //! decrement counter by 1 and emit new value
    _emitCounterValue(state - 1);
  }

  _emitCounterValue(int value) {
    emit(value);
  }

  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};
}
