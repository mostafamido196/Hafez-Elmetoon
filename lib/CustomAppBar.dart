import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Widget? leading;
  final double elevation;

   CommonAppBar({
    Key? key, // Optional key
    required this.title,//
    this.actions = const [],
    this.backgroundColor = Colors.blue,//
    this.leading,//
    this.elevation = 4.0,//
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title),
      actions: actions ??  [],
      leading: leading ?? Container(),
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
