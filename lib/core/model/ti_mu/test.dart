import 'dart:convert';

WDXTestModel wdxTestModelFromJson(String str) => WDXTestModel.fromJson(json.decode(str));

String wdxTestModelToJson(WDXTestModel data) => json.encode(data.toJson());

class WDXTestModel {
  WDXTestModel({
    this.count,
    this.topicCount,
    this.data,
  });

  int count;
  int topicCount;
  List<Datum> data;

  factory WDXTestModel.fromJson(Map<String, dynamic> json) => WDXTestModel(
    count: json["count"],
    topicCount: json["topicCount"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "topicCount": topicCount,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.score,
    this.numberOfQuestions,
    this.createTime,
    this.user,
  });

  int id;
  int score;
  int numberOfQuestions;
  DateTime createTime;
  int user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    score: json["score"],
    numberOfQuestions: json["numberOfQuestions"],
    createTime: DateTime.parse(json["create_time"]),
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "score": score,
    "numberOfQuestions": numberOfQuestions,
    "create_time": createTime.toIso8601String(),
    "user": user,
  };
}
