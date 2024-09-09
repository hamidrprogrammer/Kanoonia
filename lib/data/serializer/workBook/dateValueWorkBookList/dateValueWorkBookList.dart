// To parse this JSON data, do
//
//     final dateValueWorkBookList = dateValueWorkBookListFromJson(jsonString);

import 'dart:convert';

List<DateValueWorkBookList> dateValueWorkBookListFromJson(String str) => List<DateValueWorkBookList>.from(json.decode(str).map((x) => DateValueWorkBookList.fromJson(x)));

String dateValueWorkBookListToJson(List<DateValueWorkBookList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DateValueWorkBookList {
  int dateValue;
  bool isPresent;
  bool isPastTest;
  int totalLevel;
  int totalRank;

  DateValueWorkBookList({
    required this.dateValue,
    required this.isPresent,
    required this.isPastTest,
    required this.totalLevel,
    required this.totalRank,
  });

  factory DateValueWorkBookList.fromJson(Map<String, dynamic> json) => DateValueWorkBookList(
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
