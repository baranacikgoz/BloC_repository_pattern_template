import 'package:flutter/material.dart';
import 'package:flutter_project_template/presentation/router/screen_args.dart';
import 'package:flutter_project_template/presentation/screens/second_screen/second_screen.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  static const String homeScreen = '/';
  static const String secondScreen = '/second-screen';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case secondScreen:
        return MaterialPageRoute(
            builder: (_) =>
                SecondScreen(args: settings.arguments as SecondScreenArgs));

      default:
        throw const RouteException(Strings.routeExceptionMessage);
    }
  }

  //! Custom navigaton methods. If you want to change the way of navigating,
  //! you don't have to change it from everywhere, just change inside the functions

  //! Removes all screens and then pushes the screen
  static pushNamedAndRemoveUntil({
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

  //! Removes all screens and then pushes the screen with arguments
  static pushNamedAndRemoveUntilWithArguments(
      {required BuildContext context,
      required String pageName,
      required Object args}) {
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

  //! Pushes given page
  static push({required BuildContext context, required String pageName}) {
    Navigator.of(context).pushNamed(pageName);
  }

  //! Pushes given page with arguments
  static pushWithArgument(
      {required BuildContext context,
      required String pageName,
      required args}) {
    Navigator.of(context).pushNamed(pageName, arguments: args);
  }
}
