import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/ui/pages/login/login.dart';
import 'package:page_transition/page_transition.dart';

class WDXRouter {
  static final Map<String, WidgetBuilder> routes = {
  };

  static final String initialRoute = "/";

  static final RouteFactory onGenerateRoute = (settings) {
    switch (settings.name) {
      case WDXLoginPage.routeName: // 登录
        return PageTransition(
            child: WDXLoginPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      default:
        return null;
    }
  };

  static final RouteFactory onUnknownRoute = (setting) {
    return null;
  };
}