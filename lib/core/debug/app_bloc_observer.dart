import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print("Changed: $change");
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    print("Created $bloc");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);

    print("Closed $bloc");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    print("$bloc throws $error , stactrace: $stackTrace");
  }
}
