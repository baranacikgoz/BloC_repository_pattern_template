import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), elevation: 11, actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
