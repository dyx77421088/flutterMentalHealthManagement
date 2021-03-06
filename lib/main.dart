import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/ui/shared/size_fit.dart';
import 'package:mentalHealthManagement/ui/shared/theme/app_theme.dart';
import 'ui/pages/main/main.dart';

void main() {
  // 初始化
  WDXSizeFit.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: WDXAppTheme.norTheme,
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("首页"),),
      body: Main(),
    );
  }
}

