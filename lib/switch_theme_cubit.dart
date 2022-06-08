import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'core/themes/app_theme.dart';

class SwitchThemeCubit extends Cubit<ThemeData> {
  final ThemeData initialTheme;

  SwitchThemeCubit({required this.initialTheme}) : super(initialTheme);

  void switchTheme() {
    state == AppTheme.lightTheme ? emit(AppTheme.darkTheme) : emit(AppTheme.lightTheme);
  }
}
