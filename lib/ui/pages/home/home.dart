import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';
import 'package:mentalHealthManagement/core/services/config/http_request.dart';
import 'package:mentalHealthManagement/core/view_model/user_view_model.dart';
import 'package:mentalHealthManagement/ui/pages/test/test.dart';
import 'package:mentalHealthManagement/ui/shared/dialog/dialog.dart';
import 'home_data.dart';

class WDXHomePage extends StatefulWidget {
  @override
  _WDXHomePageState createState() => _WDXHomePageState();
}

class _WDXHomePageState extends State<WDXHomePage> {
  @override
  Widget build(BuildContext context) {
    return
      // Column(
      // children: [
      //   Text("你感到怎么样？", style: TextStyle(fontSize: 30.px,fontWeight: FontWeight.bold),),
      //   Text("     如果你感到忧郁，焦虑，失眠，压力，或者生活失控，来与我们的免费且匿名的心理健康 – 自我测验一下。"),
        ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, index) => Container(
            height: 80.px,
            child: buildItem(context, index),
          )
      //   ),
      // ],
    );
  }

  Widget buildItem(BuildContext context, index) => GestureDetector(
    child: ListTile(
      leading: data[index].image,
      title: Text(data[index].title),
      subtitle: Text(data[index].content),
    ),
    onTap: () {
      Navigator.pushNamed(context, WDXTestPage.routeName, arguments: data[index]).then((value) => {
        if (value != null) {
          showFen(context, value)
        }
      });
    },
  );
  /// 展示分数
  void showFen(BuildContext context, fen) async{
    var t = fen as WDXHomeData;
    WDXHttpRequest().request(
        "/user/score/upload",
        method: "post",
        headers: {"token": WDXUserViewModel.staticToken},
        data: {
          "score": t.fen,
          "numberOfQuestions": t.count,
        }
    ).then((value) {
      print(value["message"]);
      WDXDialog.message(context: context, message: value['message'], title: "评测结果");
    });
  }
}


