// To parse this JSON data, do
//
//     final workBookKindItem = workBookKindItemFromJson(jsonString);

import 'dart:convert';

List<WorkBookKindItem> workBookKindItemFromJson(String str) =>
    List<WorkBookKindItem>.from(
        json.decode(str).map((x) => WorkBookKindItem.fromJson(x)));

String workBookKindItemToJson(List<WorkBookKindItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkBookKindItem {
  String kind;
  String title;
  bool isDateValue;
  bool isActive;
  bool isPdf;

  WorkBookKindItem({
    required this.kind,
    required this.title,
    required this.isDateValue,
    required this.isActive,
    required this.isPdf,
  });

  factory WorkBookKindItem.fromJson(Map<String, dynamic> json) =>
      WorkBookKindItem(
        kind: json["kind"],
        title: json["title"],
        isDateValue: json["isDateValue"],
        isActive: json["isActive"],
        isPdf: json["isPdf"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "title": title,
        "isDateValue": isDateValue,
        "isActive": isActive,
        "isPdf": isPdf,
      };
}
