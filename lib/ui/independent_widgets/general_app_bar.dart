import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_project_template/core/constants/icons.dart';
import 'package:flutter_project_template/core/themes/app_theme.dart';
import 'package:flutter_project_template/switch_theme_cubit.dart';

/// A custom appBar class.
class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor.
  const GeneralAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  /// Title of appBar
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: _buildAppBarActions(context),
      elevation: 11,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

List<Widget> _buildAppBarActions(BuildContext context) {
  return [
    // ignore: prefer_if_elements_to_conditional_expressions
    context.read<SwitchThemeCubit>().state == AppTheme.lightTheme
        ? AppIcons.darkMode
        : AppIcons.lightMode,
    Switch(
      activeColor: Colors.white,
      value:
          // ignore: avoid_bool_literals_in_conditional_expressions
          context.watch<SwitchThemeCubit>().state == AppTheme.lightTheme ? true : false,
      onChanged: (value) {
        context.read<SwitchThemeCubit>().switchTheme();
      },
    ),
  ];
}
