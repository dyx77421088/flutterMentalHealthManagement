import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mentalHealthManagement/core/extension/int_extension.dart';
import 'package:mentalHealthManagement/core/model/ti_mu/test.dart';
import 'package:mentalHealthManagement/core/services/config/http_request.dart';
import 'package:mentalHealthManagement/core/services/ti_mu/ti_mu.dart';
import 'package:mentalHealthManagement/core/services/user/user_login.dart';
import 'package:mentalHealthManagement/core/view_model/user_view_model.dart';
import 'package:mentalHealthManagement/ui/pages/dang_an/dang_an.dart';
import 'package:mentalHealthManagement/ui/pages/login/login.dart';
import 'package:mentalHealthManagement/ui/pages/xlzx/xlzx.dart';
import 'package:mentalHealthManagement/ui/pages/yuet/yuet.dart';
import 'package:mentalHealthManagement/ui/shared/dialog/dialog.dart';
import 'package:mentalHealthManagement/ui/shared/image/image.dart';
import 'package:mentalHealthManagement/ui/shared/theme/my_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

class WDXPersonalContent extends StatefulWidget {

  @override
  _WDXPersonalContentState createState() => _WDXPersonalContentState();
}

class _WDXPersonalContentState extends State<WDXPersonalContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<WDXUserViewModel>(
        builder: (ctx, userVM, child)=> ListView(
          children: [
            buildAvatar(context),
            SizedBox(height: 10.px,),
            buildCard(userVM),
            SizedBox(height: 10.px,),
            !userVM.isLogin ? Text("") : buildChat(context),
            !userVM.isLogin ? Text("") : buildYueT(context),
            !userVM.isLogin ? Text("") : buildXli(context),
            !userVM.isLogin ? Text("") : buildDangAn(context),
            !userVM.isLogin ? Text("") : buildExit(context),
          ],
        ),
      ),
    );
  }

  /// 请先登录
  void plLogin(BuildContext context, WDXUserViewModel userVM) {
    Navigator.pushNamed(context, WDXLoginPage.routeName).then((value) => userVM.tongzhi());
  }

  Widget buildItem(BuildContext context, Widget leading, String title, onPressed) => RaisedButton(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      padding: EdgeInsets.zero,
      color: Theme.of(context).dialogBackgroundColor,
      child: ListTile(
        leading: leading,
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios)),
        onPressed: onPressed
  );
  var _url = 'tel:17588888888';

  /// 在线咨询
  Widget buildChat(BuildContext context) => buildItem(context, Icon(Icons.phone), "在线咨询", () async{
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  });

  /// 在线约谈
  Widget buildYueT(BuildContext context) => buildItem(context, Icon(Icons.message), "在线约谈", (){
    Navigator.pushNamed(context, WDXYueTPage.routeName);
  });

  /// 心理咨询
  Widget buildXli(BuildContext context) => buildItem(context, Icon(Icons.message), "心理咨询", (){
    Navigator.pushNamed(context, WDXXLZXPage.routeName);
  });

  /// 心理档案
  Widget buildDangAn(BuildContext context) => buildItem(context, Icon(Icons.person), "心理档案", (){
    Navigator.pushNamed(context, WDXDangAn.routeName);
  });

  Widget buildExit(BuildContext context) => Consumer<WDXUserViewModel>(
    builder: (ctx, userVM, child) => buildItem(context, Icon(Icons.exit_to_app), "退出登录", () {
      if (userVM.isLogin) {
        WDXDialog.ok(context: context, message: "是否退出登录", ok: () {
          userVM.logOut();
        });
      } else {
        WDXDialog.ok(context: context, message: "请先登录", ok: () {
          plLogin(context, userVM);
        });
      }
    }),
  );

  /// 卡片
  Widget buildCard(WDXUserViewModel userVM) => Container(
    width: double.infinity,
    height: 150.px,
    padding: EdgeInsets.all(5.px),
    child: GridView.builder(
      itemCount: 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (ctx, index) {
        if (!userVM.isLogin) return buildCardItem("10", "答题数");
        switch (index) {
          case 0: return buildCardItem("${userVM.count}", "测试数");
          case 1: return GestureDetector(child: buildCardItem("预警", "点击查看"), onTap: (){yujing(context);},);
          default: return buildCardItem("${userVM.topicCount}", "总答题数");
        }
      }
    ),
  );

  void yujing(BuildContext context) {
    WDXHttpRequest().request(
      "/user/score/predict",
      headers: {"token":WDXUserViewModel.staticToken},
    ).then((value) {
      WDXDialog.message(context: context, message: value['message'], title: "预测结果");
    });
  }

  Widget buildCardItem(String text1, String text2) => Card(
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text1, style: TextStyle(fontSize: 40.px, color: Colors.white)),
            SizedBox(height: 4),
            Text(text2, style: TextStyle(color: Color(0xccf5f5f5)),)
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.px)))
  );

  /// 头像
  Widget buildAvatar(BuildContext context) => Container(
    height: 200.px,
    width: double.infinity,
    color: WDXColors.green[300],
    child: Consumer<WDXUserViewModel>(
      builder: (ctx, userVM, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.px,height: 100.px,
            child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Container(
                  width: 80.px,height: 80.px,
                  child: GestureDetector(
                    child: CachedNetworkImage(
                      imageUrl: userVM.head ?? "http://via.placeholder.com/350x150",
                      // imageUrl: "https://img95.699pic.com/desgin_photo/40157/6029_detail.jpg!detail860/fw/820/crop/0x1309a0a0/quality/90",
                      // imageUrl: "http://via.placeholder.com/350x150",
                      placeholder: (BuildContext ctx, String url)=>Center(child: CircularProgressIndicator(),),
                      errorWidget: (ctx, url, err) => Center(child: Icon(Icons.error)),
                      imageBuilder: (ctx, img) => CircleAvatar(backgroundImage: img,),
                    ),
                    onTap: () {
                      if (userVM.isLogin) {
                        // 选择图片并上传
                        selectImage(context, userVM);
                      } else {
                        plLogin(context, userVM);
                      }
                    },
                  ),
                ),
              ),
        ),
        SizedBox(height: 10.px,),
        Text(userVM.isLogin ? userVM.nickname ?? "没名字" : "请先登录")
      ],
    ),)
  );

  void selectImage(BuildContext context, WDXUserViewModel userVM) {
    WDXDialog.zdy(context: context, body: Container(
      child: Column(
        children: [
          Container(
            height: 50.px,
            child: Center(
              child: GestureDetector(
                child: Text("手机拍摄"),
                onTap: () {
                  getImage(1, userVM);
                },
              ),
            ),
          ),
          Container(
            height: 50.px,
            child: Center(
              child: GestureDetector(
                child: Text("从相册中选择"),
                onTap: () {
                  getImage(2, userVM);
                },
              ),
            ),
          )
        ],
      ),
    ));
  }

  /// 选择图片
  void getImage(int type, WDXUserViewModel userVM) async{
    var image = type == 2 ? await WDXImage.getImageByGallery() : await WDXImage.getImageByCamera();
    WDXUserServices.avatar(id: userVM.id, imagePath: image.path).then((value) {
      if (value["head"] != null) {
        userVM.head = value['head'];
      }
    });
  }
}
