import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:replay_bloc/replay_bloc.dart';

/// Hydrated cubit will store counter's last value therefore it will remain
/// the same when you closed and re-open app.
class CounterCubit extends HydratedCubit<int> with ReplayCubitMixin {
  /// Constructor.
  CounterCubit() : super(0);

  /// increase _currentValue by 1 and emit new value
  void onIncrement() => emit(state + 1);

  /// decrement counter by 1 and emit new value
  void onDecrement() => emit(state - 1);

  @override
  void undo() {
    super.undo();

    //! Your work while cubit undo change
  }

  @override
  void redo() {
    super.redo();

    //! Your work while cubit undo change
  }

  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};
}
