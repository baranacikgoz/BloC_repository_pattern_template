import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/repositories/counter_repository.dart';
import 'core/themes/app_theme.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/constants/instances.dart';
import 'core/constants/strings.dart';
import 'core/debug/app_bloc_observer.dart';
import 'logic/counter/cubit/counter_cubit.dart';
import 'logic/internet_connectivity/cubit/internet_connectivity_cubit.dart';
import 'logic/switch_theme/cubit/switch_theme_cubit.dart';
import 'core/app_router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(() => runApp(App()),
      storage: storage, blocObserver: AppBlocObserver());
}

class App extends StatelessWidget {
  final osThemeIsLight =
      schedularBindingInstance.window.platformBrightness == Brightness.light;
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          //! Create Counter Repository instance
          create: (context) => CounterRepository(),
        ),
        // RepositoryProvider(
        //   create: (context) => AnotherRepository(),
        // ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => InternetConnectivityCubit()),

            BlocProvider(
                //! context.read<CounterRepository>()
                create: (context) => CounterCubit(context.read<CounterRepository>())),

            // If Android/IOS theme of the device is light, start app with light theme,
            // else start app with dark theme
            osThemeIsLight
                ? BlocProvider(
                    create: (context) =>
                        SwitchThemeCubit(initialTheme: AppTheme.lightTheme))
                : BlocProvider(
                    create: (context) =>
                        SwitchThemeCubit(initialTheme: AppTheme.darkTheme))
          ],
          child: Builder(builder: (context) {
            return MaterialApp(
              title: Strings.appTitle,
              theme: BlocProvider.of<SwitchThemeCubit>(context, listen: true).state,
              debugShowCheckedModeBanner: false,
              initialRoute: AppRouter.homeScreen,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          })),
    );
  }
}
