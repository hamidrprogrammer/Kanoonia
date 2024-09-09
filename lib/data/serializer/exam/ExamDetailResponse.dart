import 'dart:convert';

import 'package:kanooniha/data/serializer/exam/TargetItem.dart';

/// Status : 1
/// Data : {"state":1,"message":"","testInfo":{"testDate":13991026,"testDateInPersian":"1399 جمعه 26 دی","totalStudents":37451,"isPresent":false,"minTotalLevel":0,"maxTotalLevel":0,"avgTotalLevel":0,"stdLevel":0,"hasGoalLevel":false,"stdGoalLevel":0,"remainingDays":5,"remainingDaysPercentage":17.8571434},"targetLevels":[]}
/// Message : ""

ExamDetailResponse examDetailResponseFromJson(String str) =>
    ExamDetailResponse.fromJson(json.decode(str));

String examDetailResponseToJson(ExamDetailResponse data) =>
    json.encode(data.toJson());

class ExamDetailResponse {
  ExamDetailResponse({
    num? status,
    Data? data,
    String? message,
  }) {
    _status = status;
    _data = data;
    _message = message;
  }

  ExamDetailResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    _message = json['Message'];
  }

  num? _status;
  Data? _data;
  String? _message;

  num? get status => _status;

  Data? get data => _data;

  String? get message => _message;

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
/// message : ""
/// testInfo : {"testDate":13991026,"testDateInPersian":"1399 جمعه 26 دی","totalStudents":37451,"isPresent":false,"minTotalLevel":0,"maxTotalLevel":0,"avgTotalLevel":0,"stdLevel":0,"hasGoalLevel":false,"stdGoalLevel":0,"remainingDays":5,"remainingDaysPercentage":17.8571434}
/// targetLevels : []

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? state,
    String? message,
    TestInfo? testInfo,
    List<TargetItem>? targetLevels,
  }) {
    _state = state;
    _message = message;
    _testInfo = testInfo;
    _targetLevels = targetLevels;
  }

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    _testInfo =
        json['testInfo'] != null ? TestInfo.fromJson(json['testInfo']) : null;
    if (json['targetLevels'] != null) {
      _targetLevels = [];
      json['targetLevels'].forEach((v) {
        _targetLevels?.add(TargetItem.fromJson(v));
      });
    }
  }

  num? _state;
  String? _message;
  TestInfo? _testInfo;
  List<TargetItem>? _targetLevels;

  num? get state => _state;

  String? get message => _message;

  TestInfo? get testInfo => _testInfo;

  List<TargetItem>? get targetLevels => _targetLevels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    if (_testInfo != null) {
      map['testInfo'] = _testInfo?.toJson();
    }
    if (_targetLevels != null) {
      map['targetLevels'] = _targetLevels?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// testDate : 13991026
/// testDateInPersian : "1399 جمعه 26 دی"
/// totalStudents : 37451
/// isPresent : false
/// minTotalLevel : 0
/// maxTotalLevel : 0
/// avgTotalLevel : 0
/// stdLevel : 0
/// hasGoalLevel : false
/// stdGoalLevel : 0
/// remainingDays : 5
/// remainingDaysPercentage : 17.8571434

TestInfo testInfoFromJson(String str) => TestInfo.fromJson(json.decode(str));

String testInfoToJson(TestInfo data) => json.encode(data.toJson());

class TestInfo {
  TestInfo({
    num? testDate,
    String? testDateInPersian,
    num? totalStudents,
    bool? isPresent,
    num? minTotalLevel,
    num? maxTotalLevel,
    num? avgTotalLevel,
    num? stdLevel,
    num? stdRank,
    bool? hasGoalLevel,
    num? stdGoalLevel,
    num? remainingDays,
    num? remainingDaysPercentage,
  }) {
    _testDate = testDate;
    _testDateInPersian = testDateInPersian;
    _totalStudents = totalStudents;
    _isPresent = isPresent;
    _minTotalLevel = minTotalLevel;
    _maxTotalLevel = maxTotalLevel;
    _avgTotalLevel = avgTotalLevel;
    _stdLevel = stdLevel;
    _stdRank = stdRank;
    _hasGoalLevel = hasGoalLevel;
    _stdGoalLevel = stdGoalLevel;
    _remainingDays = remainingDays;
    _remainingDaysPercentage = remainingDaysPercentage;
  }

  TestInfo.fromJson(dynamic json) {
    _testDate = json['testDate'];
    _testDateInPersian = json['testDateInPersian'];
    _totalStudents = json['totalStudents'];
    _isPresent = json['isPresent'];
    _minTotalLevel = json['minTotalLevel'];
    _maxTotalLevel = json['maxTotalLevel'];
    _avgTotalLevel = json['avgTotalLevel'];
    _stdLevel = json['stdLevel'];
    _stdRank = json['stdRank'];
    _hasGoalLevel = json['hasGoalLevel'];
    _stdGoalLevel = json['stdGoalLevel'];
    _remainingDays = json['remainingDays'];
    _remainingDaysPercentage = json['remainingDaysPercentage'];
  }

  num? _testDate;
  String? _testDateInPersian;
  num? _totalStudents;
  bool? _isPresent;
  num? _minTotalLevel;
  num? _maxTotalLevel;
  num? _avgTotalLevel;
  num? _stdLevel;
  num? _stdRank;
  bool? _hasGoalLevel;
  num? _stdGoalLevel;
  num? _remainingDays;
  num? _remainingDaysPercentage;

  num? get testDate => _testDate;

  String? get testDateInPersian => _testDateInPersian;

  num? get totalStudents => _totalStudents;

  bool? get isPresent => _isPresent;

  num? get minTotalLevel => _minTotalLevel;

  num? get maxTotalLevel => _maxTotalLevel;

  num? get avgTotalLevel => _avgTotalLevel;

  num? get stdLevel => _stdLevel;
  num? get stdRank => _stdRank;

  bool? get hasGoalLevel => _hasGoalLevel;

  num? get stdGoalLevel => _stdGoalLevel;

  num? get remainingDays => _remainingDays;

  num? get remainingDaysPercentage => _remainingDaysPercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['testDate'] = _testDate;
    map['testDateInPersian'] = _testDateInPersian;
    map['totalStudents'] = _totalStudents;
    map['isPresent'] = _isPresent;
    map['minTotalLevel'] = _minTotalLevel;
    map['maxTotalLevel'] = _maxTotalLevel;
    map['avgTotalLevel'] = _avgTotalLevel;
    map['stdLevel'] = _stdLevel;
    map['hasGoalLevel'] = _hasGoalLevel;
    map['stdGoalLevel'] = _stdGoalLevel;
    map['remainingDays'] = _remainingDays;
    map['remainingDaysPercentage'] = _remainingDaysPercentage;
    return map;
  }
}
