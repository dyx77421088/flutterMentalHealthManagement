import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/services/config/http_request.dart';
import 'package:mentalHealthManagement/core/services/ti_mu/ti_mu.dart';
import 'package:mentalHealthManagement/ui/shared/time/time_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';
import 'package:mentalHealthManagement/core/services/user/user_login.dart';
import 'package:mentalHealthManagement/core/view_model/user_view_model.dart';

class WDXLoginContent extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<WDXLoginContent> {
  Duration get loginTime => Duration(milliseconds: 2250);

  var users = const {
    'dribbble@gmail.com': '12345',
    'hunter@gmail.com': 'hunter',
  };

  /// 登录
  Future<String> _authUser(LoginData data, WDXUserViewModel userVM) async{
    var t = await WDXUserServices.login(
      phone: data.name,
      pwd: data.password,
    );
    if (t != null) {
      /// 登录
      userVM.user = t;
      userVM.test = await WDXTiMu.lishi(token: t.id);
      return null;
    }
    return "用户名或密码错误";
  }

  /// 找回密码
  Future<String> _recoverPassword(String name) async{
    print(name);
    bool b = true;
    // kIsWeb
    await WDXHttpRequest().request(
      "/user/revisePwd",
      method: "patch",
      data: {
        "phone": name,
        "password": "123456"
      },
      // inter:InterceptorsWrapper(
      //   onError: (err) {
      //     print("哈哈哈哈哈");
      //     b = false;
      //     return null;
      //   },
      //   onRequest: (_){print("12312312"); return null;},
      //   onResponse: (_){print("33333333333333");}
      // )
    ).catchError((err) {
      b = false;
    });

    return b ? null : "手机号未注册";
  }

  /// 注册
  Future<String> _register(LoginData data, WDXUserViewModel userVM) async{
    var t = await WDXUserServices.register(
      phone: data.name,
      pwd: data.password
    );
    if (t) {
      /// 注册成功并登录
      var d = await WDXUserServices.login(
        phone: data.name,
        pwd: data.password,
      );
      if (d != null) {
        userVM.user = d;
        userVM.test = await WDXTiMu.lishi(token: d.id);
        return null;
      }
      return "登录失败";
    }
    return "注册失败";
  }

  /// 返回登录信息
  Widget buildLogin(BuildContext context) => Consumer<WDXUserViewModel>(
    builder: (ctx, userVM, child) => FlutterLogin(
      title: '登录',
      logo: 'assets/images/login.png',
      onLogin: (data) => _authUser(data, userVM),
      theme: LoginTheme(
        pageColorLight:Colors.green,
        pageColorDark: Colors.blue,
        buttonTheme: LoginButtonTheme(
          backgroundColor: Colors.blue
        ),
        primaryColor: Colors.blue
      ),
      onSignup: (data) => _register(data, userVM),
      onSubmitAnimationCompleted: () { // 登录成功之后
        Navigator.pop(context);
      },
      onRecoverPassword: _recoverPassword,
      emailValidator: (value) {
        if (value.isEmpty || !RegExp(
            r'^((13[0-9])|(14[0-9])|(15[0-9])|(166)|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$').hasMatch(value)) {
          return '手机号不合法！';
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty || value.length <= 2) {
          return '密码太短！';
        }
        return null;
      },
      messages: LoginMessages(
        usernameHint: '手机号',
        passwordHint: '密码',
        confirmPasswordHint: '确认',
        forgotPasswordButton: '忘记密码？',
        loginButton: '登录',
        signupButton: '注册',
        recoverPasswordButton: '找回密码',
        recoverPasswordIntro: '找回密码',
        recoverPasswordDescription: '新密码将发给您的手机',
        goBackButton: '返回',
        confirmPasswordError: '密码不匹配！',
        recoverPasswordSuccess: '找回密码成功',
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          buildLogin(context),
          Positioned(
            top: 10.px,
            left: 10.px,
            child: IconButton(
              icon: Icon(Icons.close, size: 40.px,),
              color: Colors.grey,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
