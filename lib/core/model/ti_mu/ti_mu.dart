import 'dart:convert';

WDXTiMuModel wdxTiMuModelFromJson(String str) => WDXTiMuModel.fromJson(json.decode(str));

String wdxTiMuModelToJson(WDXTiMuModel data) => json.encode(data.toJson());

class WDXTiMuModel {
  WDXTiMuModel({
    this.data,
  });

  List<Datum> data;

  factory WDXTiMuModel.fromJson(Map<String, dynamic> json) => WDXTiMuModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.topic,
    this.type,
  });

  int id;
  String topic;
  int type;
  /// 选择了第几个选项
  int xz = -1;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    topic: json["topic"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topic": topic,
    "type": type,
  };
}
