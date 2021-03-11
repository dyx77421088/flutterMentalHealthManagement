import 'package:mentalHealthManagement/core/model/zx/zx_model.dart';
import 'package:mentalHealthManagement/core/services/config/http_request.dart';
import 'package:mentalHealthManagement/core/view_model/user_view_model.dart';

class WDXZXService {
  /// 咨询查询
  static Future<WDXZXModel> zx({int id, int type = 1}) async{
    var t = await WDXHttpRequest().request(
      "/user/advisory/list",
      params: {
        "type": type,
        "ordering": "-create_time",
      },
      headers: {"token": id ?? WDXUserViewModel.staticToken}
    );
    return WDXZXModel.fromJson(t);
  }

  /// 发送咨询
  static Future sendZx({int id, String content, int type = 1}) async{
    await WDXHttpRequest().request(
        "/user/advisory/upload",
        method: "post",
        data: {
          "content": content,
          "type": type,
        },
        headers: {"token": id ?? WDXUserViewModel.staticToken}
    );
  }
}