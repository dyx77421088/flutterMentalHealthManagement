import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';
import 'package:mentalHealthManagement/core/model/zx/zx_model.dart';
import 'package:mentalHealthManagement/core/services/zx/zx_service.dart';
import 'package:mentalHealthManagement/ui/pages/xlzx/add_xlzx.dart';
import 'package:mentalHealthManagement/ui/pages/xlzx/look_xlzx.dart';

/// 在线约谈
class WDXYueTPage extends StatefulWidget {
  static const String routeName = "/WDXYueTPage";

  @override
  _WDXXLZXPageState createState() => _WDXXLZXPageState();
}

class _WDXXLZXPageState extends State<WDXYueTPage> {
  List<Datum> data;
  int type = 1;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async{
    data = (await WDXZXService.zx(type: type)).data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("在线约谈"),),
      body: Padding(
        padding: EdgeInsets.all(5.px),
        child: ListView(
          children: buildData(context) ?? [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, WDXAddXlzxPage.routeName, arguments: type).then((value) {
            init();
          });
        },
      ),
    );
  }

  List<Widget> buildData(BuildContext context) {
    if (data == null) return null;
    List<Widget> list = [];
    data.forEach((element) { list.add(buildItem(context, element));});
    return list;
  }

  Widget buildItem(BuildContext context, Datum e) => GestureDetector(
    child: Card(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15.px)),
      child: Container(
          height: 50.px,
          padding: EdgeInsets.all(8.px),
          child: Text(e.content, overflow: TextOverflow.ellipsis, maxLines: 1,)
      ),
    ),
    onTap: () {
      Navigator.pushNamed(context, WDXLookXlzxPage.routeName, arguments: e);
    },
  );
}
