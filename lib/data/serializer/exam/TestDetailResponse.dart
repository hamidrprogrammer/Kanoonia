import 'dart:convert';
/// Status : 1
/// Data : {"state":1,"message":"جستجوی اطلاعات آزمون کاربر با موفقیت انجام شد","testInfo":{"testDate":14010820,"testDateInPersian":"جمعه 20 آبان","totalStudents":48733,"isPresent":true,"minTotalLevel":4138,"maxTotalLevel":4309,"maxPublicLevel":4342,"maxSpecialLevel":8475,"minPublicLevel":4134,"minSpecialLevel":3368,"avgTotalLevel":4220,"stdLevel":0,"hasGoalLevel":false,"stdGoalLevel":0,"remainingDays":0,"remainingDaysPercentage":100}}
/// Message : ""

TestDetailResponse testDetailResponseFromJson(String str) => TestDetailResponse.fromJson(json.decode(str));
String testDetailResponseToJson(TestDetailResponse data) => json.encode(data.toJson());
class TestDetailResponse {
  TestDetailResponse({
      num? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  TestDetailResponse.fromJson(dynamic json) {
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
/// message : "جستجوی اطلاعات آزمون کاربر با موفقیت انجام شد"
/// testInfo : {"testDate":14010820,"testDateInPersian":"جمعه 20 آبان","totalStudents":48733,"isPresent":true,"minTotalLevel":4138,"maxTotalLevel":4309,"maxPublicLevel":4342,"maxSpecialLevel":8475,"minPublicLevel":4134,"minSpecialLevel":3368,"avgTotalLevel":4220,"stdLevel":0,"hasGoalLevel":false,"stdGoalLevel":0,"remainingDays":0,"remainingDaysPercentage":100}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? state, 
      String? message, 
      TestInfo? testInfo,}){
    _state = state;
    _message = message;
    _testInfo = testInfo;
}

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    _testInfo = json['testInfo'] != null ? TestInfo.fromJson(json['testInfo']) : null;
  }
  num? _state;
  String? _message;
  TestInfo? _testInfo;

  num? get state => _state;
  String? get message => _message;
  TestInfo? get testInfo => _testInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    if (_testInfo != null) {
      map['testInfo'] = _testInfo?.toJson();
    }
    return map;
  }

}

/// testDate : 14010820
/// testDateInPersian : "جمعه 20 آبان"
/// totalStudents : 48733
/// isPresent : true
/// minTotalLevel : 4138
/// maxTotalLevel : 4309
/// maxPublicLevel : 4342
/// maxSpecialLevel : 8475
/// minPublicLevel : 4134
/// minSpecialLevel : 3368
/// avgTotalLevel : 4220
/// stdLevel : 0
/// hasGoalLevel : false
/// stdGoalLevel : 0
/// remainingDays : 0
/// remainingDaysPercentage : 100

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
      num? maxPublicLevel, 
      num? maxSpecialLevel, 
      num? minPublicLevel, 
      num? minSpecialLevel, 
      num? avgTotalLevel, 
      num? stdLevel, 
      bool? hasGoalLevel, 
      num? stdGoalLevel, 
      num? remainingDays, 
      num? remainingDaysPercentage,}){
    _testDate = testDate;
    _testDateInPersian = testDateInPersian;
    _totalStudents = totalStudents;
    _isPresent = isPresent;
    _minTotalLevel = minTotalLevel;
    _maxTotalLevel = maxTotalLevel;
    _maxPublicLevel = maxPublicLevel;
    _maxSpecialLevel = maxSpecialLevel;
    _minPublicLevel = minPublicLevel;
    _minSpecialLevel = minSpecialLevel;
    _avgTotalLevel = avgTotalLevel;
    _stdLevel = stdLevel;
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
    _maxPublicLevel = json['maxPublicLevel'];
    _maxSpecialLevel = json['maxSpecialLevel'];
    _minPublicLevel = json['minPublicLevel'];
    _minSpecialLevel = json['minSpecialLevel'];
    _avgTotalLevel = json['avgTotalLevel'];
    _stdLevel = json['stdLevel'];
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
  num? _maxPublicLevel;
  num? _maxSpecialLevel;
  num? _minPublicLevel;
  num? _minSpecialLevel;
  num? _avgTotalLevel;
  num? _stdLevel;
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
  num? get maxPublicLevel => _maxPublicLevel;
  num? get maxSpecialLevel => _maxSpecialLevel;
  num? get minPublicLevel => _minPublicLevel;
  num? get minSpecialLevel => _minSpecialLevel;
  num? get avgTotalLevel => _avgTotalLevel;
  num? get stdLevel => _stdLevel;
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
    map['maxPublicLevel'] = _maxPublicLevel;
    map['maxSpecialLevel'] = _maxSpecialLevel;
    map['minPublicLevel'] = _minPublicLevel;
    map['minSpecialLevel'] = _minSpecialLevel;
    map['avgTotalLevel'] = _avgTotalLevel;
    map['stdLevel'] = _stdLevel;
    map['hasGoalLevel'] = _hasGoalLevel;
    map['stdGoalLevel'] = _stdGoalLevel;
    map['remainingDays'] = _remainingDays;
    map['remainingDaysPercentage'] = _remainingDaysPercentage;
    return map;
  }

}