// To parse this JSON data, do
//
//     final supportItem = supportItemFromJson(jsonString);

import 'dart:convert';

List<SupportItem> supportItemFromJson(String str) => List<SupportItem>.from(json.decode(str).map((x) => SupportItem.fromJson(x)));

String supportItemToJson(List<SupportItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportItem {
  int id;
  String appId;
  int userId;
  int kindId;
  String body;
  bool hasAnswer;
  dynamic dateAnswer;
  dynamic supporterId;
  dynamic answerText;
  dynamic answerPicUrl;
  DateTime? dateInsert;

  SupportItem({
    required this.id,
    required this.appId,
    required this.userId,
    required this.kindId,
    required this.body,
    required this.hasAnswer,
    this.dateAnswer,
    this.supporterId,
    this.answerText,
    this.answerPicUrl,
    required this.dateInsert,
  });

  factory SupportItem.fromJson(Map<String, dynamic> json) => SupportItem(
    id: json["id"],
    appId: json["appId"],
    userId: json["userId"],
    kindId: json["kindId"],
    body: json["body"],
    hasAnswer: json["hasAnswer"],
    dateAnswer: json["dateAnswer"],
    supporterId: json["supporterId"],
    answerText: json["answerText"],
    answerPicUrl: json["answerPicUrl"],
    dateInsert: json["dateInsert"] != null ? DateTime.parse(json["dateInsert"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appId": appId,
    "userId": userId,
    "kindId": kindId,
    "body": body,
    "hasAnswer": hasAnswer,
    "dateAnswer": dateAnswer,
    "supporterId": supporterId,
    "answerText": answerText,
    "answerPicUrl": answerPicUrl,
    "dateInsert": dateInsert,
  };
}
