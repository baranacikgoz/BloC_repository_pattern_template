import 'package:flutter/material.dart';

import '../../core/constants/strings.dart';

class CustomSnackbar {
  const CustomSnackbar._();

  /// Function is null by default. If you want snackbar  disappear after
  /// click action, leave function as null.
  /// Action message is ```Strings.defaultSnacbarActionMessage``` by default
  static void showSnackbarWithAction(
      {required BuildContext context,
      required String message,
      String actionMessage = Strings.defaultSnackbarActionMessage,
      Function? function}) {
    _removeCurrentSnackbar(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: actionMessage,
          onPressed: function == null
              ? () => _removeCurrentSnackbar(context)
              : () => function,
        ),
      ),
    );
  }

  static void showSnackbarWithTimedMessage(
      BuildContext context, String message, int milliseconds) {
    _removeCurrentSnackbar(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: milliseconds),
      ),
    );
  }

  static void _removeCurrentSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
