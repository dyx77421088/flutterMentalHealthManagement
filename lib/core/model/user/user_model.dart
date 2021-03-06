
import 'dart:convert';

WDXUserModel wdxUserModelFromJson(String str) => WDXUserModel.fromJson(json.decode(str));

String wdxUserModelToJson(WDXUserModel data) => json.encode(data.toJson());

class WDXUserModel {
  WDXUserModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Data data;
  int code;

  factory WDXUserModel.fromJson(Map<String, dynamic> json) => WDXUserModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "code": code,
  };
}

class Data {
  Data({
    this.id,
    this.userName,
    this.phoneNumber,
    this.token,
  });

  int id;
  String userName;
  String phoneNumber;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "phone_number": phoneNumber,
    "token": token,
  };
}
