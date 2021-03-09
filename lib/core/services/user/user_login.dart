import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mentalHealthManagement/core/model/user/user_model.dart';
import 'package:mentalHealthManagement/core/services/config/http_request.dart';
import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/view_model/user_view_model.dart';
//验证信息
typedef OnResponse = dynamic Function(Response e);
class WDXUserServices {
  /// 登录
  static Future<WDXUserModel> login({
    @required String phone,
    @required String pwd,
  }) async{
    WDXUserModel model;
    await WDXHttpRequest().request(
      "/user/login",
      data: {
        "phone": phone,
        "pwd": pwd
      },
      method: "post",
      inter:InterceptorsWrapper(
        onResponse: (resp) {
          if (resp.statusCode == 200) {
            model = WDXUserModel.fromJson(resp.data);
          }
        },
        onError: (_){},
        onRequest: (_){}
      )
    );

    return model;
  }

  /// token登录
  static Future<WDXUserModel> tokenLogin({int token}) async{
    WDXUserModel model;
    print("token= ");
    print(WDXUserViewModel.staticToken);
    print(token);
    if(token == null) token = WDXUserViewModel.staticToken;
    await WDXHttpRequest().request(
        "/user/tokenLogin",
        method: "post",
        headers: {
          "token": token,
        },
        inter:InterceptorsWrapper(
            onResponse: (resp) {
              if (resp.statusCode == 200) {
                model = WDXUserModel.fromJson(resp.data);
              }
            },
            onError: (err){
              return err;
            },
            onRequest: (_){}
        )
    );
    return model;
  }

  /// 注册
  static Future<bool> register({
    @required String phone,
    @required String pwd,
  }) async{
    bool isOk = false;
    await WDXHttpRequest().request(
      "/user/register",
      data: {
        "phone": phone,
        "pwd": pwd
      },
      method: "post",
      inter:InterceptorsWrapper(
        onResponse: (res) {
          if (res.statusCode == 201) isOk = true;
          else isOk = false;
        },
        onError: (_){},
        onRequest: (_){}
      )
    );

    return isOk;
  }

  /// 头像上传
  static Future avatar({
    @required int id,
    @required String imagePath
  }) async{
    return WDXHttpRequest().request(
      "/user/updateHead",
      method: "patch",
      headers: {
        "token": id
      },
      data: FormData.fromMap({
        "head": await MultipartFile.fromFile(imagePath)
      })
    );
  }

  /// 修改信息
  static Future<WDXUserModel> update({
    @required int id,
    @required Map<String, dynamic> params
  }) async{
    bool isOk = false;
    WDXUserModel model;
    Map<String, dynamic> t2 = {};
    params.forEach((key, value) {
      if (value != null && "" != value) {t2[key] = value;
    }});
    var t = await WDXHttpRequest().request(
      "/user/update",
      method: "patch",
      data: t2,
      headers: {
        "token": id
      },
      inter:InterceptorsWrapper(
        onResponse: (res) {
          if (res.statusCode == 200) model = WDXUserModel.fromJson(res.data);
        },
      )
    );
    print(t);
    return model;
  }
}