import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/icons.dart';
import '../../core/themes/app_theme.dart';
import '../../switch_theme_cubit.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GeneralAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

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
    context.read<SwitchThemeCubit>().state == AppTheme.lightTheme
        ? AppIcons.darkMode
        : AppIcons.lightMode,
    Switch(
        activeColor: Colors.white,
        value:
            context.watch<SwitchThemeCubit>().state == AppTheme.lightTheme ? true : false,
        onChanged: (value) {
          context.read<SwitchThemeCubit>().switchTheme();
        })
  ];
}
