import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/ui/shared/theme/my_colors.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';

class WDXAppTheme {
  // 公有属性
  static double bodyText1Size = 10.px;
  static double bodyText2Size = 12.px;

  // 影响在输入框中的table提示信息
  static double subTitle1Size = 16.px;
  static double subTitle2Size = 8.px;

  static double headline1Size = 36.px;
  static double headline2Size = 32.px;
  static double headline3Size = 28.px;
  static double headline4Size = 24.px;
  static double headline5Size = 20.px;
  static double headline6Size = 16.px;

  static double appbarSize = 16.px;



  // 普通模式
  static final Color norTextColors = Colors.black87;
  static final Color subTitle1Color = Colors.black;

  static final ThemeData norTheme = ThemeData(
    primarySwatch: WDXColors.blue,
    highlightColor: WDXColors.blue[700],
//    canvasColor: Color.fromRGBO(255, 224, 222, 1),
    canvasColor: WDXColors.blue[50],
    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: bodyText1Size, color: norTextColors),
      bodyText2: TextStyle(fontSize: bodyText2Size, color: norTextColors),
      subtitle1: TextStyle(fontSize: subTitle1Size, color: subTitle1Color),
      headline1: TextStyle(fontSize: headline1Size, color: Colors.black54),
      headline2: TextStyle(fontSize: headline2Size, color: Colors.black54),
      headline3: TextStyle(fontSize: headline3Size, color: Colors.black54),
      headline4: TextStyle(fontSize: headline4Size, color: Colors.black54),
      headline5: TextStyle(fontSize: headline5Size, color: Colors.black54),
    ),
    appBarTheme: AppBarTheme(
      color: WDXColors.blue[300],
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.px))),
    ),
  );
}