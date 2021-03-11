import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/model/zx/zx_model.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';
import 'package:mentalHealthManagement/ui/shared/time/time_util.dart';

class WDXLookXlzxPage extends StatefulWidget {
  static const String routeName = "/WDXLookXlzxPage";
  final Datum data;

  WDXLookXlzxPage(this.data);

  @override
  _WDXLookXlzxPageState createState() => _WDXLookXlzxPageState();
}

class _WDXLookXlzxPageState extends State<WDXLookXlzxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("查看"),),
      body: ListView(
        children: [
          buildCard(widget.data.content ?? "暂无问题", widget.data.createTime),
          SizedBox(height: 10.px,),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10.px,),
          //   child: Text("回复:", style: TextStyle(fontSize: 20.px),),
          // ),
          buildCard(widget.data.reply ?? "暂无回复", widget.data.finishTime),
        ],
      ),
    );
  }

  Widget buildCard(String text, DateTime time) => Container(
    padding: EdgeInsets.all(10.px),
    height: 200.px,
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(10.px),
        child: Stack(
          children: [
              Container(
                height: 150.px,
                child: Text(text,
                  maxLines: 5,
                  overflow: TextOverflow.visible,
                )
            ),
            Positioned(
              child: time == null ? Text("") : Text(WDXTime.getNowDate(timeStamp: time.millisecondsSinceEpoch ~/ 1000)),
              right: 0,
              bottom: 0,
            )
          ],
        ),
      ),
    ),
  );
}
