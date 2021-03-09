// To parse this JSON data, do
//
//     final wdxUserModel = wdxUserModelFromJson(jsonString);

import 'dart:convert';

WDXUserModel wdxUserModelFromJson(String str) => WDXUserModel.fromJson(json.decode(str));

String wdxUserModelToJson(WDXUserModel data) => json.encode(data.toJson());

class WDXUserModel {
  WDXUserModel({
    this.id,
    this.phone,
    this.nickname,
    this.createTime,
    this.head,
    this.sex,
    this.birth,
    this.hometown,
    this.ethnic,
    this.physicalCondition,
    this.qq,
    this.character,
    this.hobby,
    this.likeSubjects,
    this.description,
  });

  int id;
  String phone;
  String nickname;
  DateTime createTime;
  String head;
  int sex;
  DateTime birth;
  String hometown;
  String ethnic;
  String physicalCondition;
  String qq;
  String character;
  String hobby;
  String likeSubjects;
  String description;

  factory WDXUserModel.fromJson(Map<String, dynamic> json) => WDXUserModel(
    id: json["id"],
    phone: json["phone"],
    nickname: json["nickname"],
    createTime: json["create_time"] == null ? null : DateTime.parse(json["create_time"]),
    head: json["head"],
    sex: json["sex"],
    birth: json["birth"] == null ? null : DateTime.parse(json["birth"]),
    hometown: json["hometown"],
    ethnic: json["ethnic"],
    physicalCondition: json["physicalCondition"],
    qq: json["QQ"],
    character: json["character"],
    hobby: json["hobby"],
    likeSubjects: json["likeSubjects"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone": phone,
    "nickname": nickname,
    "create_time": createTime.toIso8601String(),
    "head": head,
    "sex": sex,
    "birth": birth.toIso8601String(),
    "hometown": hometown,
    "ethnic": ethnic,
    "physicalCondition": physicalCondition,
    "QQ": qq,
    "character": character,
    "hobby": hobby,
    "likeSubjects": likeSubjects,
    "description": description,
  };
}
