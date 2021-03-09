import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class WDXDialog {
  static message({@required BuildContext context, message, String title = ""}) {
    AwesomeDialog(
      context: context,
      desc: message,
      title: title,
      dialogType: DialogType.NO_HEADER,
      btnOkOnPress: () {},
      btnOkText: "确定",
      btnCancelText: "取消"
    ).show();
  }

  static Future ok({@required BuildContext context, message, ok}) {
    return AwesomeDialog(
      context: context,
      desc: message,
      title: "",
      dialogType: DialogType.NO_HEADER,
      btnOkOnPress: ok,
      btnCancelOnPress: (){},
      btnOkText: "确定",
      btnCancelText: "取消"
    ).show();
  }

  static Future zdy({@required BuildContext context, @required Widget body}) => AwesomeDialog(
    context: context,
    desc: "",
    title: "",
    dialogType: DialogType.NO_HEADER,
    body: body,
    aligment: Alignment.bottomCenter
  ).show();
}