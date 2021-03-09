import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentalHealthManagement/core/router/route.dart';
import 'package:mentalHealthManagement/ui/shared/size_fit.dart';
import 'package:mentalHealthManagement/ui/shared/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'core/view_model/user_view_model.dart';
import 'ui/pages/main/main.dart';

void main() {
  // 初始化
  WDXSizeFit.initialize();

  if (!kIsWeb && Platform.isAndroid) {
    // 透明状态栏
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => WDXUserViewModel(),),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: WDXAppTheme.norTheme,
      home: MyHomePage(),
      routes: WDXRouter.routes,
      initialRoute: WDXRouter.initialRoute,
      onGenerateRoute: WDXRouter.onGenerateRoute,
      onUnknownRoute: WDXRouter.onUnknownRoute,
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("首页")),
      body: Main(),
    );
  }
}

