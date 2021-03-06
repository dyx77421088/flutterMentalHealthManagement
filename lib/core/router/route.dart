import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/model/zx/zx_model.dart';
import 'package:mentalHealthManagement/ui/pages/dang_an/dang_an.dart';
import 'package:mentalHealthManagement/ui/pages/home/home_data.dart';
import 'package:mentalHealthManagement/ui/pages/login/login.dart';
import 'package:mentalHealthManagement/ui/pages/test/start_test.dart';
import 'package:mentalHealthManagement/ui/pages/test/test.dart';
import 'package:mentalHealthManagement/ui/pages/xlzx/add_xlzx.dart';
import 'package:mentalHealthManagement/ui/pages/xlzx/look_xlzx.dart';
import 'package:mentalHealthManagement/ui/pages/xlzx/xlzx.dart';
import 'package:mentalHealthManagement/ui/pages/yuet/yuet.dart';
import 'package:page_transition/page_transition.dart';

class WDXRouter {
  static final Map<String, WidgetBuilder> routes = {
  };

  static final String initialRoute = "/";
  // static final String initialRoute = WDXXLZXPage.routeName;

  static final RouteFactory onGenerateRoute = (settings) {
    switch (settings.name) {
      case WDXLoginPage.routeName: // 登录
        return PageTransition(
            child: WDXLoginPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      case WDXTestPage.routeName: // 测试
        WDXHomeData t = settings.arguments as WDXHomeData;
        return PageTransition(
            child: WDXTestPage(
              title: t.title,
              content: t.content,
              count: t.count,
            ),
            type: PageTransitionType.fade,
            alignment: Alignment.topCenter
        );
      case WDXStartTestPage.routeName: // 开始测试
        return PageTransition(
            child: WDXStartTestPage(count: settings.arguments as int,),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      case WDXDangAn.routeName: // 心理档案
        return PageTransition(
            child: WDXDangAn(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      case WDXYueTPage.routeName: // 在线约谈
        return PageTransition(
            child: WDXYueTPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      case WDXXLZXPage.routeName: // 心理咨询
        return PageTransition(
            child: WDXXLZXPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      case WDXAddXlzxPage.routeName: // 添加咨询
        return PageTransition(
            child: WDXAddXlzxPage(settings.arguments as int),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      case WDXLookXlzxPage.routeName: // 查看咨询
        return PageTransition(
            child: WDXLookXlzxPage(settings.arguments as Datum),
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