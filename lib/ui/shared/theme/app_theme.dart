import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/ui/shared/theme/my_colors.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';

class WDXAppTheme {
  // 普通模式
  static final Color norTextColors = Colors.black87;
  static final Color subTitle1Color = Colors.black;

  static final ThemeData norTheme = ThemeData(
    primarySwatch: WDXColors.green,
    highlightColor: WDXColors.green[700],
//    canvasColor: Color.fromRGBO(255, 224, 222, 1),
    canvasColor: WDXColors.green[50],
    appBarTheme: AppBarTheme(
      color: WDXColors.green[300],
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.px))),
    ),
  );
}