import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otakunow/config/palette.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.tint400,
      elevation: 0.0,
      centerTitle: true,
      title: Image(
        image: AssetImage('assets/images/otaku_now_logo.png'),
        height: 60,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
