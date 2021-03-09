import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mentalHealthManagement/ui/pages/home/home.dart';
import 'package:mentalHealthManagement/ui/pages/login/login.dart';
import 'package:mentalHealthManagement/ui/pages/personal/personal.dart';
import 'package:mentalHealthManagement/ui/shared/theme/my_colors.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _index = 0;
  final List<GButton> items = [
    GButton(
      text: "首页",
      icon: Icons.message,
      backgroundColor: Colors.green,
    ),
    GButton(
      text: "个人中心",
      icon: Icons.person,
      backgroundColor: Color(0xff66cc00),
    ),
  ];

  List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    pages = [
      WDXHomePage(),
      WDXPersonal(),
    ];

    return Scaffold(

        body: IndexedStack(
          index: _index,
          children: this.pages,
        ),
        bottomNavigationBar: Container(
          color: WDXColors.green[300],
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 8.px),
            child: Container(
              child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24.px,
                padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 5.px),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Theme.of(context).appBarTheme.color,
                tabs: items,
                selectedIndex: this._index,
                onTabChange: (index){
                  setState(() {
                    _index = index;
                  });
                },
              ),
            ),
          ),
        )
    );
  }
}
