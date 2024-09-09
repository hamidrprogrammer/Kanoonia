import 'dart:convert';

/// Status : 1
/// Data : {"state":1,"message":"جستجوی اطلاعات آزمون های کاربر با موفقیت انجام شد","testDates":[{"DateValue":14010904,"testDateInPersian":"جمعه 4 آذر","isPresent":true,"isPastTest":true},{"DateValue":14010820,"testDateInPersian":"جمعه 20 آبان","isPresent":true,"isPastTest":true},{"DateValue":14010806,"testDateInPersian":"جمعه 6 آبان","isPresent":true,"isPastTest":true}],"lastTestInfo":{"testDate":14010806,"testDateInPersian":"جمعه 6 آبان","totalStudents":44240,"isPresent":true,"minTotalLevel":4029,"maxTotalLevel":5282,"maxPublicLevel":6639,"maxSpecialLevel":8294,"minPublicLevel":4140,"minSpecialLevel":3458,"avgTotalLevel":4458,"stdLevel":0,"hasGoalLevel":false,"stdGoalLevel":0,"remainingDays":0,"remainingDaysPercentage":100}}
/// Message : null

PastTestResponse pastTestResponseFromJson(String str) =>
    PastTestResponse.fromJson(json.decode(str));

String pastTestResponseToJson(PastTestResponse data) =>
    json.encode(data.toJson());

class PastTestResponse {
  PastTestResponse({
    num? status,
    Data? data,
    dynamic message,
  }) {
    _status = status;
    _data = data;
    _message = message;

  }

  PastTestResponse.fromJson(dynamic json) {
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
/// message : "جستجوی اطلاعات آزمون های کاربر با موفقیت انجام شد"
/// testDates : [{"DateValue":14010904,"testDateInPersian":"جمعه 4 آذر","isPresent":true,"isPastTest":true},{"DateValue":14010820,"testDateInPersian":"جمعه 20 آبان","isPresent":true,"isPastTest":true},{"DateValue":14010806,"testDateInPersian":"جمعه 6 آبان","isPresent":true,"isPastTest":true}]
/// lastTestInfo : {"testDate":14010806,"testDateInPersian":"جمعه 6 آبان","totalStudents":44240,"isPresent":true,"minTotalLevel":4029,"maxTotalLevel":5282,"maxPublicLevel":6639,"maxSpecialLevel":8294,"minPublicLevel":4140,"minSpecialLevel":3458,"avgTotalLevel":4458,"stdLevel":0,"hasGoalLevel":false,"stdGoalLevel":0,"remainingDays":0,"remainingDaysPercentage":100}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? state,
    String? message,
    List<TestDates>? testDates,
    LastTestInfo? lastTestInfo,
    bool? showChart,
  }) {
    _state = state;
    _message = message;
    _testDates = testDates;
    _lastTestInfo = lastTestInfo;
    _showChart = showChart;
  }

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    if (json['testDates'] != null) {
      _testDates = [];
      json['testDates'].forEach((v) {
        _testDates?.add(TestDates.fromJson(v));
      });
    }
    _lastTestInfo = json['lastTestInfo'] != null
        ? LastTestInfo.fromJson(json['lastTestInfo'])
        : null;
    _showChart = json['ShowChart'];
  }

  num? _state;
  String? _message;
  List<TestDates>? _testDates;
  LastTestInfo? _lastTestInfo;
  bool? _showChart;

  num? get state => _state;

  String? get message => _message;

  List<TestDates>? get testDates => _testDates;

  LastTestInfo? get lastTestInfo => _lastTestInfo;

  bool? get showChart => _showChart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    if (_testDates != null) {
      map['testDates'] = _testDates?.map((v) => v.toJson()).toList();
    }
    if (_lastTestInfo != null) {
      map['lastTestInfo'] = _lastTestInfo?.toJson();
    }
    map['ShowChart'] = _showChart;

    return map;
  }
}

/// testDate : 14010806
/// testDateInPersian : "جمعه 6 آبان"
/// totalStudents : 44240
/// isPresent : true
/// minTotalLevel : 4029
/// maxTotalLevel : 5282
/// maxPublicLevel : 6639
/// maxSpecialLevel : 8294
/// minPublicLevel : 4140
/// minSpecialLevel : 3458
/// avgTotalLevel : 4458
/// stdLevel : 0
/// hasGoalLevel : false
/// stdGoalLevel : 0
/// remainingDays : 0
/// remainingDaysPercentage : 100

LastTestInfo lastTestInfoFromJson(String str) =>
    LastTestInfo.fromJson(json.decode(str));

String lastTestInfoToJson(LastTestInfo data) => json.encode(data.toJson());

class LastTestInfo {
  LastTestInfo({
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
    _maxPublicLevel = maxPublicLevel;
    _maxSpecialLevel = maxSpecialLevel;
    _minPublicLevel = minPublicLevel;
    _minSpecialLevel = minSpecialLevel;
    _avgTotalLevel = avgTotalLevel;
    _stdLevel = stdLevel;
    _stdRank = stdRank;
    _hasGoalLevel = hasGoalLevel;
    _stdGoalLevel = stdGoalLevel;
    _remainingDays = remainingDays;
    _remainingDaysPercentage = remainingDaysPercentage;
  }

  LastTestInfo.fromJson(dynamic json) {
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
  num? _maxPublicLevel;
  num? _maxSpecialLevel;
  num? _minPublicLevel;
  num? _minSpecialLevel;
  num? _avgTotalLevel;
  num? _stdLevel;
  num? _stdRank;
  bool? _hasGoalLevel;
  num? _stdGoalLevel;
  num? _remainingDays;
  num? _remainingDaysPercentage;

  void setTestDate(num? newDate){
    _testDate = newDate;
  }

  void setStdLevel(num? stdLevel){
    _stdLevel = stdLevel;
  }

  void setStdRank(num? stdRank){
    _stdRank = stdRank;
  }

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

/// DateValue : 14010904
/// testDateInPersian : "جمعه 4 آذر"
/// isPresent : true
/// isPastTest : true

TestDates testDatesFromJson(String str) => TestDates.fromJson(json.decode(str));

String testDatesToJson(TestDates data) => json.encode(data.toJson());

class TestDates {
  TestDates({
    num? dateValue,
    String? testDateInPersian,
    bool? isPresent,
    bool? isPastTest,
  }) {
    _dateValue = dateValue;
    _testDateInPersian = testDateInPersian;
    _isPresent = isPresent;
    _isPastTest = isPastTest;
  }

  TestDates.fromJson(dynamic json) {
    _dateValue = json['DateValue'];
    _testDateInPersian = json['testDateInPersian'];
    _isPresent = json['isPresent'];
    _isPastTest = json['isPastTest'];
  }

  num? _dateValue;
  String? _testDateInPersian;
  bool? _isPresent;
  bool? _isPastTest;

  num? get dateValue => _dateValue;

  String? get testDateInPersian => _testDateInPersian;

  bool? get isPresent => _isPresent;

  bool? get isPastTest => _isPastTest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DateValue'] = _dateValue;
    map['testDateInPersian'] = _testDateInPersian;
    map['isPresent'] = _isPresent;
    map['isPastTest'] = _isPastTest;
    return map;
  }
}

class TarazDataModel {
  final double minTaraz, maxSpecialTaraz,maxPublicTaraz, avgTaraz, userTaraz;

  const TarazDataModel({
    required this.minTaraz,
    required this.maxSpecialTaraz,
    required this.maxPublicTaraz,
    required this.avgTaraz,
    required this.userTaraz,
  });
}

extension TarazExtensions on PastTestResponse {
  TarazDataModel get getTarazModel => TarazDataModel(
      minTaraz: data?.lastTestInfo?.minTotalLevel?.toDouble() ?? 0.0,
      maxSpecialTaraz: data?.lastTestInfo?.maxSpecialLevel?.toDouble() ?? 0.0,
      maxPublicTaraz: data?.lastTestInfo?.maxPublicLevel?.toDouble() ?? 0.0,
      avgTaraz: data?.lastTestInfo?.avgTotalLevel?.toDouble() ?? 0.0,
      userTaraz: data?.lastTestInfo?.stdLevel?.toDouble() ?? 0.0);
}
