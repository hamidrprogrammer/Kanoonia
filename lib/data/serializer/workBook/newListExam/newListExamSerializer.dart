// To parse this JSON data, do
//
//     final dateValueListSerializer = dateValueListSerializerFromJson(jsonString);

import 'dart:convert';

List<DateValueListSerializer> dateValueListSerializerFromJson(String str) => List<DateValueListSerializer>.from(json.decode(str).map((x) => DateValueListSerializer.fromJson(x)));

String dateValueListSerializerToJson(List<DateValueListSerializer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DateValueListSerializer {
  int dateValue;
  bool isPresent;
  bool isPastTest;
  int totalLevel;
  int totalRank;

  DateValueListSerializer({
    required this.dateValue,
    required this.isPresent,
    required this.isPastTest,
    required this.totalLevel,
    required this.totalRank,
  });

  factory DateValueListSerializer.fromJson(Map<String, dynamic> json) => DateValueListSerializer(
    dateValue: json["dateValue"],
    isPresent: json["isPresent"],
    isPastTest: json["isPastTest"],
    totalLevel: json["totalLevel"],
    totalRank: json["totalRank"],
  );

  Map<String, dynamic> toJson() => {
    "dateValue": dateValue,
    "isPresent": isPresent,
    "isPastTest": isPastTest,
    "totalLevel": totalLevel,
    "totalRank": totalRank,
  };
}
