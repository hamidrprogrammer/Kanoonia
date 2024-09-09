// To parse this JSON data, do
//
//     final supportKindItem = supportKindItemFromJson(jsonString);

import 'dart:convert';

List<SupportKindItem> supportKindItemFromJson(String str) => List<SupportKindItem>.from(json.decode(str).map((x) => SupportKindItem.fromJson(x)));

String supportKindItemToJson(List<SupportKindItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportKindItem {
  int kindId;
  String title;

  SupportKindItem({
    required this.kindId,
    required this.title,
  });

  factory SupportKindItem.fromJson(Map<String, dynamic> json) => SupportKindItem(
    kindId: json["kindId"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "kindId": kindId,
    "title": title,
  };
}
