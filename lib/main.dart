import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/constants/strings.dart';
import 'core/debug/app_bloc_observer.dart';
import 'logic/counter/cubit/counter_cubit.dart';
import 'logic/internet_connectivity/cubit/internet_connectivity_cubit.dart';
import 'logic/theme/cubit/theme_cubit.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(() => runApp(const App()),
      storage: storage, blocObserver: AppBlocObserver());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetConnectivityCubit()),
        BlocProvider(create: (context) => CounterCubit()),
        BlocProvider(create: (context) => ThemeCubit())
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            title: Strings.appTitle,
            theme: state,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.homeScreen,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
