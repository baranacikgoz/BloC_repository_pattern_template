import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.lightTheme);

  void switchTheme() {
    state == AppTheme.lightTheme
        ? emit(AppTheme.darkTheme)
        : emit(AppTheme.lightTheme);
  }
}
