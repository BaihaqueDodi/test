import 'package:flutter/material.dart';
import 'sidebar.dart';

class sideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SideBar(),
      ],
    );
  }
}
