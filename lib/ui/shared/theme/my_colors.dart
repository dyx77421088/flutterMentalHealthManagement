import 'package:flutter/material.dart';

class WDXColors {
  static const int navBarPrimaryValue = 0xff823935;
  static const MaterialColor navBar = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{ //999463
      50: Color.fromRGBO(178, 200, 187, 1),
      100: Color.fromRGBO(69, 137, 148, 1),
      200: Color.fromRGBO(117, 121, 74, 1),
      300: Color.fromRGBO(114, 83, 52, 1),
      400: Color.fromRGBO(220, 87, 18, 1),
      500: Color(navBarPrimaryValue),
      600: Color.fromRGBO(137, 190, 178, 1),
      700: Color.fromRGBO(201, 186, 131, 1),
      800: Color.fromRGBO(222, 221, 140, 1),
      900: Color.fromRGBO(222, 156, 83, 1),
    },
  );

  static const int _bluePrimaryValue = 0xff4c40c3;
  static const MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{ //999463
      50: Color(0xffe6e3f7),
      100: Color(0xffc2beeb),
      200: Color(0xffa8a2e1),
      300: Color(0xff8379d5),
      400: Color(0xff675bcc),
      500: Color(_bluePrimaryValue),
      600: Color(0xff4034a7),
      700: Color(0xff30277e),
      800: Color(0xff231d5c),
      900: Color(0xff18143f),
    },
  );
}