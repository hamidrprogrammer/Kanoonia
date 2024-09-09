import 'dart:convert';

import 'PreTarget.dart';

/// Status : 1
/// Data : {"state":1,"message":"جستجوی دروس با موفقیت انجام شد","courses":[{"CourseId":394,"CourseName":"زيست‌شناسي يازدهم","AveragePercent":2.7,"Sigma":2.67438658983983,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/TajrobiZist.png"},{"CourseId":395,"CourseName":"شيمي يازدهم","AveragePercent":2.1,"Sigma":1.98473575638299,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/shimi.png"},{"CourseId":396,"CourseName":"رياضي يازدهم","AveragePercent":1.3,"Sigma":1.8605758901333602,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/riyazi.png"},{"CourseId":397,"CourseName":"فيزيك يازدهم","AveragePercent":2,"Sigma":2.30160223616325,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/fizik.jpg"},{"CourseId":615,"CourseName":"زمين‌شناسي يازدهم","AveragePercent":2.7,"Sigma":2.59958210380882,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/TajrobiZamin.jpg"},{"CourseId":1495,"CourseName":"رياضي يازدهم- سوالات‌ موازي","AveragePercent":1.1,"Sigma":1.53930776328809,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/riyazi.png"},{"CourseId":1706,"CourseName":"فيزيك يازدهم- سوالات‌ موازي","AveragePercent":0.9,"Sigma":1.51216897261249,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/fizik.jpg"},{"CourseId":2186,"CourseName":"زيست‌شناسي يازدهم- آشنا","AveragePercent":3.1,"Sigma":3.04614863934072,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/TajrobiZist.png"}]}
/// Message : null

ExamCourceResponse examCourceResponseFromJson(String str) =>
    ExamCourceResponse.fromJson(json.decode(str));

String examCourceResponseToJson(ExamCourceResponse data) =>
    json.encode(data.toJson());

class ExamCourceResponse {
  ExamCourceResponse({
    num? status,
    Data? data,
    dynamic message,
  }) {
    _status = status;
    _data = data;
    _message = message;
  }

  ExamCourceResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    _message = json['Message'];
  }

  num? _status;
  Data? _data;
  dynamic _message;

  num? get status => _status;

  Data? get data => _data;

  dynamic get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    if (_data != null) {
      map['Data'] = _data?.toJson();
    }
    map['Message'] = _message;
    return map;
  }
}

/// state : 1
/// message : "جستجوی دروس با موفقیت انجام شد"
/// courses : [{"CourseId":394,"CourseName":"زيست‌شناسي يازدهم","AveragePercent":2.7,"Sigma":2.67438658983983,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/TajrobiZist.png"},{"CourseId":395,"CourseName":"شيمي يازدهم","AveragePercent":2.1,"Sigma":1.98473575638299,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/shimi.png"},{"CourseId":396,"CourseName":"رياضي يازدهم","AveragePercent":1.3,"Sigma":1.8605758901333602,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/riyazi.png"},{"CourseId":397,"CourseName":"فيزيك يازدهم","AveragePercent":2,"Sigma":2.30160223616325,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/fizik.jpg"},{"CourseId":615,"CourseName":"زمين‌شناسي يازدهم","AveragePercent":2.7,"Sigma":2.59958210380882,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/TajrobiZamin.jpg"},{"CourseId":1495,"CourseName":"رياضي يازدهم- سوالات‌ موازي","AveragePercent":1.1,"Sigma":1.53930776328809,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/riyazi.png"},{"CourseId":1706,"CourseName":"فيزيك يازدهم- سوالات‌ موازي","AveragePercent":0.9,"Sigma":1.51216897261249,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/fizik.jpg"},{"CourseId":2186,"CourseName":"زيست‌شناسي يازدهم- آشنا","AveragePercent":3.1,"Sigma":3.04614863934072,"CoursePictureURL":"http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/TajrobiZist.png"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? state,
    String? message,
    List<Courses>? courses,
  }) {
    _state = state;
    _message = message;
    _courses = courses;
  }

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    if (json['courses'] != null) {
      _courses = [];
      json['courses'].forEach((v) {
        _courses?.add(Courses.fromJson(v));
      });
    }
  }

  num? _state;
  String? _message;
  List<Courses>? _courses;

  num? get state => _state;

  String? get message => _message;

  List<Courses>? get courses => _courses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    if (_courses != null) {
      map['courses'] = _courses?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// CourseId : 394
/// CourseName : "زيست‌شناسي يازدهم"
/// AveragePercent : 2.7
/// Sigma : 2.67438658983983
/// CoursePictureURL : "http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/TajrobiZist.png"

Courses coursesFromJson(String str) => Courses.fromJson(json.decode(str));

String coursesToJson(Courses data) => json.encode(data.toJson());

class Courses {
  Courses(
      {num? courseId,
      String? courseName,
      num? averagePercent,
      num? sigma,
      String? coursePictureURL,
      PreTarget? preTarget}) {
    _courseId = courseId;
    _courseName = courseName;
    _averagePercent = averagePercent;
    _sigma = sigma;
    _coursePictureURL = coursePictureURL;
    _preTarget = preTarget;
  }

  Courses.fromJson(dynamic json) {
    _courseId = json['CourseId'];
    _courseName = json['CourseName'];
    _averagePercent = json['AveragePercent'];
    _sigma = json['Sigma'];
    _coursePictureURL = json['CoursePictureURL'];
    _preTarget = json['preTarget'] != null ? PreTarget.fromJson(json['preTarget']) : null;
  }

  num? _courseId;
  String? _courseName;
  num? _averagePercent;
  num? _sigma;
  String? _coursePictureURL;
  PreTarget? _preTarget;

  num? get courseId => _courseId;

  String? get courseName => _courseName;

  num? get averagePercent => _averagePercent;

  num get sigma => _sigma ?? 0;

  String? get coursePictureURL => _coursePictureURL;

  PreTarget? get preTarget => _preTarget;

  void clearPreTarget() {
    _preTarget = null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CourseId'] = _courseId;
    map['CourseName'] = _courseName;
    map['AveragePercent'] = _averagePercent;
    map['Sigma'] = _sigma;
    map['CoursePictureURL'] = _coursePictureURL;
    return map;
  }
}
