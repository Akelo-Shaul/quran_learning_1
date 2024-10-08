import 'package:flutter/material.dart';

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  DecoratedTabBar(
      {Key? key, required this.tabBar,
      required this.decoration,
      required this.bgcolor}) : super(key: key);

  final TabBar tabBar;
  final BoxDecoration? decoration;
  Color bgcolor;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgcolor,
      child: Stack(
        children: [
          decoration == null
              ? Positioned.fill(child: Container())
              : Positioned.fill(child: Container(decoration: decoration)),
          tabBar,
        ],
      ),
    );
  }
}
