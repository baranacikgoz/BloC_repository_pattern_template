import 'package:crypto_repository/crypto_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/core/app_router/app_router.dart';
import 'package:flutter_project_template/core/constants/instances.dart';
import 'package:flutter_project_template/core/constants/strings.dart';
import 'package:flutter_project_template/core/debug/app_bloc_observer.dart';
import 'package:flutter_project_template/core/themes/app_theme.dart';
import 'package:flutter_project_template/switch_theme_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(App()),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}

/// App class.
class App extends StatelessWidget {
  /// Constructor.
  App({Key? key}) : super(key: key);

  /// Determines whether device's os is using dark theme or light.
  final osThemeIsLight =
      schedularBindingInstance.window.platformBrightness == Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        //! Provide Crypto Repository instance
        RepositoryProvider.value(
          value: CryptoRepository.instance,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // If Android/IOS theme of the device is light, start app with light theme,
          // else start app with dark theme

          // ignore: prefer_if_elements_to_conditional_expressions
          osThemeIsLight
              ? BlocProvider(
                  create: (context) =>
                      SwitchThemeCubit(initialTheme: AppTheme.lightTheme),
                )
              : BlocProvider(
                  create: (context) => SwitchThemeCubit(
                    initialTheme: AppTheme.darkTheme,
                  ),
                )
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
              title: Strings.appTitle,
              theme: context.watch<SwitchThemeCubit>().state,
              debugShowCheckedModeBanner: false,
              initialRoute: AppRouter.homeScreen,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
