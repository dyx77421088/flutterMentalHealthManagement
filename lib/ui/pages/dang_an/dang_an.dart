import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';
import 'package:mentalHealthManagement/core/services/user/user_login.dart';
import 'package:mentalHealthManagement/core/view_model/user_view_model.dart';
import 'package:mentalHealthManagement/ui/shared/theme/my_colors.dart';
import 'package:mentalHealthManagement/ui/shared/time/time_util.dart';
import 'package:provider/provider.dart';


class WDXDangAn extends StatefulWidget {
  static const String routeName = "/WDXDangAn";

  @override
  _WDXDangAnState createState() => _WDXDangAnState();
}

class _WDXDangAnState extends State<WDXDangAn> {
  TextEditingController jiGuan, mingZu, qq, xg, xqah, xhkm, ms;
  String birth;
  int birthI;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async{
    var user = await WDXUserServices.tokenLogin();
    jiGuan = TextEditingController(text: user.hometown);
    print(user.hometown);
    mingZu = TextEditingController(text: user.ethnic);
    qq = TextEditingController(text: user.qq);
    xg = TextEditingController(text: user.character);
    xqah = TextEditingController(text: user.hobby);
    xhkm = TextEditingController(text: user.likeSubjects);
    ms = TextEditingController(text: user.description);

    value = user.sex;
    jk = getjk(user.physicalCondition);
    birth = user.birth==null ? "请选择" : WDXTime.getNowDate(timeStamp: user.birth.millisecondsSinceEpoch ~/ 1000);
    birthI = user.birth==null ? DateTime.now().millisecondsSinceEpoch ~/ 1000 :user.birth.millisecondsSinceEpoch ~/ 1000;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("心理档案"), actions: [
        Consumer<WDXUserViewModel>(
          builder: (ctx, userVM, child) => TextButton(
              onPressed: (){
                Navigator.pop(context);
                save(userVM);
              }, child: Text("保存", style: TextStyle(color: Colors.black),)
          ),
        )
      ],),
      body: Container(
        padding: EdgeInsets.all(5.px),
        child: Consumer<WDXUserViewModel>(
          builder: (ctx, userVM, child) => !userVM.isLogin ? Text("") : ListView(
            children: [
              buildTitle("性别"),
              buildSex(userVM),
              buildTitle("生日"),
              buildBirth(context),
              buildTitle("籍贯"),
              buildForm(tc: jiGuan),
              buildTitle("民族"),
              buildForm(tc: mingZu),
              buildTitle("健康状况"),
              buildJianKang(userVM),
              buildTitle("QQ"),
              buildForm(tc: qq),
              buildTitle("性格"),
              buildForm(tc: xg),
              buildTitle("兴趣爱好"),
              buildForm(tc: xqah),
              buildTitle("喜欢科目"),
              buildForm(tc: xhkm),
              buildTitle("描述"),
              buildForm(tc: ms),
            ],
          ),
        ),
      ),
    );
  }
  /// 标题
  Widget buildTitle(String text) => Padding(
    padding: EdgeInsets.symmetric(vertical: 5.px),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.px),
      color: WDXColors.green[500],
      child: Text(text, style: TextStyle(color: Colors.black),),
    ),
  );
  int value = 1;
  /// 性别
  Widget buildSex(WDXUserViewModel userVM) {
    //
    return Row(
      children: [
        Radio(value: 1, groupValue: value, onChanged: (value){
          userVM.sex = value;
          setState(() {
            this.value = value;
          });
        }),
        Text("男"),
        Radio(value: 2, groupValue: value, onChanged: (value){
          userVM.sex = value;
          setState(() {
            this.value = value;
          });
        }),
        Text("女"),
      ],
    );
  }

  Widget buildBirth(BuildContext context) => Column(
    children: [
      Text("你的生日是:$birth",),
      ElevatedButton(
        child: Text("修改生日"),
        onPressed: (){
          selectBirth(context);
        }
      )
  ],);

  /// 选择日期并提交
  void selectBirth(BuildContext context) async{
    var result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    birth = WDXTime.getNowDate(timeStamp: result.millisecondsSinceEpoch ~/ 1000);
    birthI = result.millisecondsSinceEpoch ~/ 1000;
    setState(() {});
  }

  WDXJK jk = WDXJK.jiankang;
  Widget buildJianKang(WDXUserViewModel userVM) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.px),
      child: DropdownButton(
        items: [
          DropdownMenuItem(child: Text("健康"), onTap: (){}, value: WDXJK.jiankang,),
          DropdownMenuItem(child: Text("一般"), onTap: (){}, value: WDXJK.yiban,),
          DropdownMenuItem(child: Text("较差"), onTap: (){}, value: WDXJK.jiaocha,),
        ],
        hint: Text(switchJk(jk)),
        onChanged: (t){
          jk = t;
          setState(() {});
        },
      ),
    );
  }

  WDXJK getjk(String jk) {
    switch(jk) {
      case "健康" : return WDXJK.jiankang;
      case "一般" : return WDXJK.yiban;
      case "较差" : return WDXJK.jiaocha;
    }
    return WDXJK.yiban;
  }

  String switchJk(WDXJK jk) {
    switch(jk) {
      case WDXJK.jiankang : return "健康";
      case WDXJK.yiban : return "一般";
      case WDXJK.jiaocha : return "较差";
    }
    return "一般";
  }

  /// 编辑栏
  Widget buildForm({TextEditingController tc, WDXUserViewModel userVM}) {
    return TextFormField(
      controller: tc,
    );
  }
  
  /// 保存
  void save(WDXUserViewModel userVM) async{
    var user = await WDXUserServices.update(id: WDXUserViewModel.staticToken, params: {
      "sex": value,
      "birth": WDXTime.toTime(timeStamp: birthI),
      "hometown": jiGuan.text,
      "ethnic": mingZu.text,
      "physicalCondition": switchJk(jk),
      "QQ": qq.text,
      "character": xg.text,
      "hobby": xqah.text,
      "likeSubjects": xhkm.text,
      "description": ms.text
    });
    userVM.user = user;
    userVM.tongzhi();
  }
}

enum WDXJK {
  jiankang,
  yiban,
  jiaocha
}
