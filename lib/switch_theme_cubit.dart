import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_project_template/core/themes/app_theme.dart';

/// Theme switching cubit.
class SwitchThemeCubit extends Cubit<ThemeData> {
  /// Constructor.
  SwitchThemeCubit({required this.initialTheme}) : super(initialTheme);

  /// Initial theme will provide by schedulerBinding.
  final ThemeData initialTheme;

  /// Switches the theme
  void switchTheme() {
    state == AppTheme.lightTheme ? emit(AppTheme.darkTheme) : emit(AppTheme.lightTheme);
  }
}
