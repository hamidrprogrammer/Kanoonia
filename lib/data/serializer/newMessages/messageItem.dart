// To parse this JSON data, do
//
//     final newMessageItem = newMessageItemFromJson(jsonString);

import 'dart:convert';

List<NewMessageItem> newMessageItemsFromJson(String str) =>
    List<NewMessageItem>.from(
        json.decode(str).map((x) => NewMessageItem.fromJson(x)));

String newMessageItemToJson(List<NewMessageItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewMessageItem {
  int? id;
  String? insertMessageDateGregorian;
  String? insertDate;
  String? title;
  String? message;
  int? messageReference;
  String? filePath;
  String? oName;
  String? oFamily;
  bool? hasSeen;
  int? messageKind;

  NewMessageItem({
    this.id,
    this.insertMessageDateGregorian,
    this.insertDate,
    this.title,
    this.message,
    this.messageReference,
    this.filePath,
    this.oName,
    this.oFamily,
    this.hasSeen,
    this.messageKind,
  });

  factory NewMessageItem.fromJson(Map<String, dynamic> json) => NewMessageItem(
        id: json["id"],
        insertMessageDateGregorian: json["insertMessageDate_Gregorian"],
        insertDate: json["insertDate"],
        title: json["title"],
        message: json["message"],
        messageReference: json["messageReference"],
        filePath: json["filePath"],
        oName: json["oName"],
        oFamily: json["oFamily"],
        hasSeen: json["hasSeen"],
        messageKind: json["messageKind"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "insertMessageDate_Gregorian": insertMessageDateGregorian,
        "insertDate": insertDate,
        "title": title,
        "message": message,
        "messageReference": messageReference,
        "filePath": filePath,
        "oName": oName,
        "oFamily": oFamily,
        "hasSeen": hasSeen,
        "messageKind": messageKind,
      };
}

