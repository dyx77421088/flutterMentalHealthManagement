import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/model/ti_mu/test.dart';
import 'package:mentalHealthManagement/core/model/user/user_model.dart';
import 'package:mentalHealthManagement/core/services/user/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// 用户的一些信息的通知
class WDXUserViewModel extends ChangeNotifier {
  static int staticToken;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;

  WDXUserViewModel() {
    print("执行");
    init().then((value) {
      print("是否为空${prefs == null}");
      if (prefs.getBool("isLogin") == null) {
        // 注销
        logOut();
        return;
      }
      // 尝试登录
      if (id != null) {
        login();
      } else {
        // 注销
        print("注销");
        logOut();
        return;
      }
    });
  }

  login () async{
    var t = await WDXUserServices.tokenLogin(token: id);
    if (t == null) {logOut();return;}
    _saveInfo(t);
  }


  Future<bool> init() async {
    prefs = await _prefs;
    return true;
  }

  /// 注销
  void logOut() {
    prefs.clear();
    prefs.setBool("isLogin", false);
    staticToken = null;
    notifyListeners();
  }

  /// 保存信息
  set user(WDXUserModel user) {
    _saveInfo(user);
    // notifyListeners();
  }

  /// 测试数
  set test(WDXTestModel test) {
    _saveTest(test);
  }

  void _saveTest(WDXTestModel test) async{
    SharedPreferences prefs = await _prefs;
    prefs.setInt("count", test.count);
    prefs.setInt("topicCount", test.topicCount);
  }

  void tongzhi() {
    notifyListeners();
  }

  void _saveInfo(WDXUserModel user) async{
    SharedPreferences prefs = await _prefs;
    print(prefs == null);
    prefs.setBool("isLogin", true);
    staticToken = user.id;
    prefs.setInt("id", user.id);
    prefs.setString("phone", user.phone);
    prefs.setString("nickname", user.nickname);
    prefs.setInt("createTime", user.createTime.millisecondsSinceEpoch ~/ 1000);
    if(user.head != null)
      prefs.setString("head", user.head);
    prefs.setInt("sex", user.sex);
    if (user.birth != null)
      prefs.setInt("birth", user.birth.millisecondsSinceEpoch ~/ 1000);
    prefs.setString("hometown", user.hometown);
    prefs.setString("ethnic", user.ethnic);
    // 健康状况
    prefs.setString("physicalCondition", user.physicalCondition);
    prefs.setString("qq", user.qq);
    // 字符
    prefs.setString("character", user.character);
    prefs.setString("hobby", user.hobby);
    prefs.setString("likeSubjects", user.likeSubjects);
    prefs.setString("description", user.description);
    print("保存信息成功");
  }

  /// 用户id
  int get id => !isLogin ? null : prefs.getInt("id");

  /// 昵称
  String get nickname => !isLogin ? null : prefs.getString("nickname");

  /// 创建时间
  int get createTime => !isLogin ? null : prefs.getInt("createTime");

  /// 头像
  String get head => !isLogin ? null : prefs.getString("head");

  /// 性别
  int get sex => !isLogin ? null : prefs.getInt("sex");

  /// 生日
  int get birth => !isLogin ? null : prefs.getInt("birth");

  /// 籍贯
  String get hometown => !isLogin ? null : prefs.getString("hometown");

  /// 民族
  String get ethnic => !isLogin ? null : prefs.getString("ethnic");

  /// 健康情况
  String get physicalCondition => !isLogin ? null : prefs.getString("physicalCondition");

  /// qq
  String get qq => !isLogin ? null : prefs.getString("qq");

  /// 性格
  String get character => !isLogin ? null : prefs.getString("character");

  /// 爱好
  String get hobby => !isLogin ? null : prefs.getString("hobby");

  /// 喜欢科目
  String get likeSubjects => !isLogin ? null : prefs.getString("likeSubjects");

  /// 描述
  String get description => !isLogin ? null : prefs.getString("description");

  /// 总题目数
  int get topicCount => !isLogin ? null : prefs.getInt("topicCount");

  /// 测试数
  int get count => !isLogin ? null : prefs.getInt("count");

  /// 是否登录
  bool get isLogin => prefs == null ? false : (prefs.getBool("isLogin"));

  set head(String head) {
    prefs.setString("head", head);
    notifyListeners();
  }

  set sex(int sex) {
    prefs.setInt("sex", sex);
    notifyListeners();
  }

  set birth(int birth) {
    prefs.setInt("birth", birth);
    notifyListeners();
  }

  set physicalCondition(String physicalCondition) {
    prefs.setString("physicalCondition", physicalCondition);
    notifyListeners();
  }
}
