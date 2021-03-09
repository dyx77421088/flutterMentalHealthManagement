import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';
import 'package:mentalHealthManagement/core/services/config/http_request.dart';
import 'package:mentalHealthManagement/core/view_model/user_view_model.dart';
import 'package:mentalHealthManagement/ui/pages/login/login.dart';
import 'package:mentalHealthManagement/ui/pages/test/start_test.dart';
import 'package:mentalHealthManagement/ui/shared/dialog/dialog.dart';
import 'package:provider/provider.dart';

class WDXTestPage extends StatefulWidget {
  static const String routeName = "/WDXTestPage";
  final String title, content;
  final int count;

  WDXTestPage({this.title="SDS抑郁自评量表", this.content="国际通用的抑郁自评量表，可以快速了解自身的抑郁水平。", this.count = 10});

  @override
  _WDXTestPageState createState() => _WDXTestPageState();
}

class _WDXTestPageState extends State<WDXTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("测试"),),
      body: Container(
        color: Color(0xffF1F1F1),
        padding: EdgeInsets.all(5.px),
        child: Column(
          children: [
            buildItem(
              text: widget.title,
              bgColor: Color(0xff49C9C3),
              fontColor: Colors.white
            ),
            buildItem(
                text: widget.content,
                bgColor: Colors.white,
                fontColor: Colors.black
            ),
            SizedBox(height: 10.px,),
            buildItem(
                text: "测评指标",
                bgColor: Color(0xffD2F1F0),
                fontColor: Colors.black
            ),
            buildItem(
                text: "题目数：${widget.count}",
                bgColor: Colors.white,
                fontColor: Colors.black
            ),
            buildItem(
                text: "预计用时：${widget.count ~/ 5 + 1}分钟",
                bgColor: Colors.white,
                fontColor: Colors.black
            ),
            SizedBox(height: 30.px,),
            Container(
              width: double.infinity,
              child: Consumer<WDXUserViewModel>(
                builder: (ctx, userVM, child) => ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text("开始答题"),
                  onPressed: (){
                    startTest(context, userVM);
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 点击开始测试按钮后执行的监听
  void startTest(BuildContext context, WDXUserViewModel userVM) {
    if(!userVM.isLogin) { // 如果用户没有登录
      WDXDialog.ok(context: context, message: "需登录后才能答题", ok: () {
        Navigator.pushNamed(context, WDXLoginPage.routeName).then((value) => userVM.tongzhi());
      });
      return;
    }

    Navigator.pushNamed(context, WDXStartTestPage.routeName, arguments: widget.count).then((value) {
      if (value != null)
        // showFen(context, value);
        Navigator.pop(context, value);
    });
  }


  Widget buildItem({String text, Color bgColor, Color fontColor}) => Container(
    padding: EdgeInsets.all(8.px),
    width: double.infinity,
    height: 30.px,
    color: bgColor,
    child: Text(text, style: TextStyle(color: fontColor),),
  );
}
