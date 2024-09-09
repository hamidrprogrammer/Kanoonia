// To parse this JSON data, do
//
//     final easyQuestionItem = easyQuestionItemFromJson(jsonString);

import 'dart:convert';

List<EasyQuestionItemResponse> easyQuestionItemFromJson(String str) => List<EasyQuestionItemResponse>.from(json.decode(str).map((x) => EasyQuestionItemResponse.fromJson(x)));

String easyQuestionItemToJson(List<EasyQuestionItemResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EasyQuestionItemResponse {
  int counter;
  int courseId;
  String courseName;
  int testDate;
  int questionNo;
  int answer;
  int isWrong;

  EasyQuestionItemResponse({
    required this.counter,
    required this.courseId,
    required this.courseName,
    required this.testDate,
    required this.questionNo,
    required this.answer,
    required this.isWrong,
  });

  factory EasyQuestionItemResponse.fromJson(Map<String, dynamic> json) => EasyQuestionItemResponse(
    counter: json["counter"] ?? 0,
    courseId: json["courseId"] ?? 0,
    courseName: json["courseName"] ?? '',
    testDate: json["testDate"] ?? 0,
    questionNo: json["questionNo"] ?? 0,
    answer: json["answer"] ?? 0,
    isWrong: json["isWrong"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "counter": counter,
    "courseId": courseId,
    "courseName": courseName,
    "testDate": testDate,
    "questionNo": questionNo,
    "answer": answer,
    "isWrong": isWrong,
  };
}
