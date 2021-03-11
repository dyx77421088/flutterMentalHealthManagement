import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';
import 'package:mentalHealthManagement/core/services/zx/zx_service.dart';
import 'package:mentalHealthManagement/ui/shared/dialog/dialog.dart';

/// 添加心理咨询
class WDXAddXlzxPage extends StatefulWidget {
  static const String routeName = "/WDXAddXlzxPage";
  int type;
  WDXAddXlzxPage(this.type);

  @override
  _WDXAddXlzxPageState createState() => _WDXAddXlzxPageState();
}

class _WDXAddXlzxPageState extends State<WDXAddXlzxPage> {
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("添加"),),
      body: Container(
        padding: EdgeInsets.all(10.px),
        child: ListView(
          children: [
            buildEdit(context),
            SizedBox(height: 50.px,),
            ElevatedButton(
              onPressed: (){
                if (text.text.isEmpty) {
                  WDXDialog.message(context: context, message: "内容不能为空");
                  return;
                }
                WDXZXService.sendZx(
                    content: text.text,
                    type: widget.type
                ).then((value) => Navigator.pop(context));

              },
              child: Text("提交"),
            )
          ],
        )
      ),
    );
  }

  Widget buildEdit(BuildContext context) => TextFormField(
    controller: text,
    decoration: InputDecoration(
      hintText: "请填写咨询内容",
      border: OutlineInputBorder(),

    ),
    maxLength: 100,
    maxLines: 4,
  );
}
