import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/ui/pages/login/login.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          child: Text("登录"),
          onPressed: () {
            Navigator.pushNamed(context, WDXLoginPage.routeName);
          },
        ),
      ),
    );
  }
}
