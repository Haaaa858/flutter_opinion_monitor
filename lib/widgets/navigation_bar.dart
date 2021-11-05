import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StatusStyle { LIGHT_CONTENT, DART_CONTENT }

class NavigationBar extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final Widget child;
  final double height;

  NavigationBar(
      {Key? key,
      this.statusStyle = StatusStyle.DART_CONTENT,
      this.color = Colors.white,
      this.height = 46,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _setAndroidSystemBar();
    double top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
      child: child,
    );
  }

  _setAndroidSystemBar() {
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前
      // MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: statusStyle == StatusStyle.DART_CONTENT
              ? Brightness.dark
              : Brightness.light);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
