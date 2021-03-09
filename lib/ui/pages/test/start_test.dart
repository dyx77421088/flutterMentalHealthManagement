import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/model/ti_mu/ti_mu.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';
import 'package:mentalHealthManagement/core/services/ti_mu/ti_mu.dart';
import 'package:mentalHealthManagement/ui/pages/home/home_data.dart';
import 'package:mentalHealthManagement/ui/shared/dialog/dialog.dart';

class WDXStartTestPage extends StatefulWidget {
  static const String routeName = "/WDXStartTestPage";
  final count;
  WDXStartTestPage({this.count=10});

  @override
  _WDXStartTestState createState() => _WDXStartTestState();
}

class _WDXStartTestState extends State<WDXStartTestPage> {
  List<Datum> tiMu;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    getT();
  }
  void getT() async{
    tiMu = (await WDXTiMu.getTiMu(count: widget.count)).data;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(title: Text("开始做题"), actions: [
          FlatButton(onPressed: (){tiJiao(context);}, child: Text("提交", style: TextStyle(color: Colors.black, fontSize: 15.px),))
        ],),

        body: tiMu == null ? Center(child: CircularProgressIndicator()) : Column(
          children: [
            buildTiMu(_index),
            Container(
              padding: EdgeInsets.all(8.px),
              child: Row(
                children: [
                  _index == 0 ? SizedBox() : Expanded(child: FlatButton(
                    child: Text("上一题", style: TextStyle(color: Colors.black),),
                    onPressed: (){
                      setState(() {
                        _index--;
                      });
                    },
                  )),
                  _index == tiMu.length - 1 ? SizedBox() : Expanded(child: FlatButton(
                    child: Text("下一题", style: TextStyle(color: Colors.black),),
                    onPressed: (){
                      setState(() {
                        _index++;
                      });
                    },
                  ))
                ],
              ),
            )
          ],
        ),
      ),
      onWillPop: () async{
        bool b = false;
        await WDXDialog.ok(context: context, message: "是否退出答题", ok: () {b = true;});
        return b;
        // return false;
      }
    );
  }
  var f = [
    [0, 5, 10],
    [2, 4, 6, 8, 10]
  ];
  void tiJiao(BuildContext context) {
    bool t = true;
    int fen = 0;
    tiMu.forEach((element) {
      if (element.xz == -1) t = false;
      else fen += f[element.type-1][element.xz-1];
    });
    if (t) {
      WDXDialog.ok(context: context, message: "是否提交", ok: () {
        print("提交!!!");
        fen = fen * 10  ~/ tiMu.length;
        Navigator.pop(context, WDXHomeData(fen: fen, count: widget.count));
      });
    } else {
      WDXDialog.message(context: context, message: "请完成所有题目");
    }
  }

  /// 题目
  Widget buildTiMu(index) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(width: double.infinity,height: 10.px,),
        buildTitle(),
        SizedBox(height: 20.px,),
        Container(
            padding: EdgeInsets.all(8.px),
            child: buildXuanXiang(type: tiMu[_index].type)
        ),
      ],
    );
  }

  /// 题目内容
  Widget buildTitle() => Text("(${_index+1}/${tiMu.length})${tiMu[_index].topic}", style: TextStyle(fontSize: 20.px, fontWeight: FontWeight.bold),);

  /// 选项
  Widget buildXuanXiang({int type = 1}) {
    if (type == 1) {
      return Column(
        children: [
          buildItem("经常是", 1),
          SizedBox(height: 10.px,),
          buildItem("偶尔是", 2),
          SizedBox(height: 10.px,),
          buildItem("完全没有", 3),
        ],
      );
    } else {
      return Column(
        children: [
          buildItem("完全不符", 1),
          SizedBox(height: 10.px,),
          buildItem("基本不符", 2),
          SizedBox(height: 10.px,),
          buildItem("不太确定", 3),
          SizedBox(height: 10.px,),
          buildItem("基本符合", 4),
          SizedBox(height: 10.px,),
          buildItem("完全符合", 5),
        ],
      );
    }
  }
  
  Widget buildItem(String title, int index) => GestureDetector(
    child: Container(
      width: double.infinity,
      height: 50.px,
      color: tiMu[this._index].xz == index ? Colors.red : Colors.white,
      child: Center(child: Text(title, style: TextStyle(fontSize: 15.px),),),
    ),
    onTap: () {
      setState(() {
        tiMu[_index].xz = index;
      });
    },
  );
}
