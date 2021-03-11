// To parse this JSON data, do
//
//     final wdxzxModel = wdxzxModelFromJson(jsonString);

import 'dart:convert';

WDXZXModel wdxZXModelFromJson(String str) => WDXZXModel.fromJson(json.decode(str));

String wdxZXModelToJson(WDXZXModel data) => json.encode(data.toJson());

class WDXZXModel {
  WDXZXModel({
    this.count,
    this.data,
  });

  int count;
  List<Datum> data;

  factory WDXZXModel.fromJson(Map<String, dynamic> json) => WDXZXModel(
    count: json["count"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.content,
    this.reply,
    this.type,
    this.status,
    this.createTime,
    this.finishTime,
    this.user,
  });

  int id;
  String content;
  String reply;
  int type;
  int status;
  DateTime createTime;
  DateTime finishTime;
  int user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    content: json["content"],
    reply: json["reply"],
    type: json["type"],
    status: json["status"],
    createTime: DateTime.parse(json["create_time"]),
    finishTime: DateTime.parse(json["finish_time"]),
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "reply": reply,
    "type": type,
    "status": status,
    "create_time": createTime.toIso8601String(),
    "finish_time": finishTime.toIso8601String(),
    "user": user,
  };
}
