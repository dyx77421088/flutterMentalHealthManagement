import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/model/ti_mu/test.dart';
import 'package:mentalHealthManagement/core/model/ti_mu/ti_mu.dart';
import 'package:mentalHealthManagement/core/services/config/http_request.dart';
import 'package:mentalHealthManagement/core/view_model/user_view_model.dart';

class WDXTiMu {
  /// 获得题目
  static Future<WDXTiMuModel> getTiMu({
    int count = 10,
  }) async{
    var t = await WDXHttpRequest().request(
      "/topic/randomList",
        params: {
        "count": count
      }
    );
    return WDXTiMuModel.fromJson(t);
  }

  /// 提交分数
  static Future tiJiao({@required int score, @required int numberOfQuestions}) {
    return WDXHttpRequest().request("/user/score/upload",
      method: "post",
      data: {
        "score": score,
        "numberOfQuestions": numberOfQuestions
      }
    );
  }

  /// 获得历史答题情况
  static Future<WDXTestModel> lishi({int token}) async{
    WDXTestModel model;
    if (token == null) token = WDXUserViewModel.staticToken;
    var t = await WDXHttpRequest().request(
      "/user/score/list",
      headers: {"token": token},
      inter:InterceptorsWrapper(
        onResponse: (resp) {
          if (resp.statusCode == 200) {
            model = WDXTestModel.fromJson(resp.data);
          }
        },
      )
    );
    print(t);
    return model;
  }
}