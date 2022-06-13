import 'package:flutter/material.dart';

import 'package:flutter_project_template/core/app_router/screen_args.dart';
import 'package:flutter_project_template/core/constants/strings.dart';
import 'package:flutter_project_template/core/exceptions/route_exception.dart';
import 'package:flutter_project_template/ui/screens/home_screen/home_screen.dart';
import 'package:flutter_project_template/ui/screens/second_screen/second_screen.dart';

/// This the class that will handle routing.
class AppRouter {
  const AppRouter._();

  /// Static name of homescreen in order to avoid typos.
  static const String homeScreen = '/';

  /// Static name of secondScreen in order to avoid typos.
  static const String secondScreen = '/second-screen';

  /// The routing will depend on that function.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute<dynamic>(builder: (_) => const HomeScreen());

      case secondScreen:
        assert(settings.arguments != null, "Screen args can't be null");
        return MaterialPageRoute<dynamic>(
          builder: (_) => SecondScreen(
            args: settings.arguments! as SecondScreenArgs,
          ),
        );

      default:
        throw const RouteException(message: Strings.routeExceptionMessage);
    }
  }

  //! Custom navigaton methods. If you want to change the way of navigating,
  //! you don't have to change it from everywhere, just change here

  /// Removes all screens and then pushes the given screen
  static void pushThisRemoveRest({
    required BuildContext context,
    required String pageName,
  }) {
    // If navigator can remove current screen, removes it
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        pageName,
        (route) => false, // false --> remove all screens
      );
    } else {
      // left no screen to remove, therefore pushes the given screen
      push(context: context, pageName: pageName);
    }

    Navigator.of(context).pushNamedAndRemoveUntil(pageName, (route) => false);
  }

  /// Removes all screens and then pushes the given screen with arguments
  static void pushThisRemoveRestWithArguments({
    required BuildContext context,
    required String pageName,
    required Object args,
  }) {
    // If navigator can remove current screen, removes it
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        pageName,
        (route) => false,
        arguments: args,
      );
    } else {
      // left no screen to remove, then push the given screen
      push(context: context, pageName: pageName);
    }
  }

  /// Pushes given page
  static void push({required BuildContext context, required String pageName}) {
    Navigator.of(context).pushNamed(pageName);
  }

  /// Pushes given page with arguments
  static void pushWithArgument({
    required BuildContext context,
    required String pageName,
    required Object args,
  }) {
    Navigator.of(context).pushNamed(pageName, arguments: args);
  }
}
