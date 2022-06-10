import 'package:flutter/material.dart';

import '../../core/constants/strings.dart';

class CustomSnackbar {
  const CustomSnackbar._();

  /// Shows snackbar with action button.
  ///
  /// Function is null by default. By default, snackbar will disappear after
  /// clicking action.
  ///
  /// Action message is ```Strings.defaultSnackbarActionMessage``` by default
  static void showSnackbarWithAction(
      {required BuildContext context,
      required String message,
      String actionMessage = Strings.defaultSnackbarActionMessage,
      Function? function,
      bool removeCurrent = true,
      int milliseconds = 2500}) {
    if (removeCurrent) {
      _removeCurrentSnackbar(context: context);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: milliseconds),
        action: SnackBarAction(
          label: actionMessage,
          onPressed: function == null
              ? () => _removeCurrentSnackbar(context: context)
              : () => function(),
        ),
      ),
    );
  }

  /// Shows snackbar with message only, no action button.
  static void showSnackbarWithTimedMessage(
      {required BuildContext context, required String message, int milliseconds = 2500}) {
    _removeCurrentSnackbar(context: context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: milliseconds),
      ),
    );
  }

  static void _removeCurrentSnackbar({
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
