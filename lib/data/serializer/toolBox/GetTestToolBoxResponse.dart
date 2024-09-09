import 'dart:convert';
/// Status : 1
/// Data : {"state":1,"message":"","testToolBox":[{"Id":696,"TestDate":13990914,"GroupCode":22,"TypeIndex":2,"TypeAction":"url","Title":"معرفی رشته علوم تغذیه","Description":"معرفی رشته علوم تغذیه از طریق گفت‌و‌گو با دانشجویان","FileUrl":"https://www.kanoon.ir/Article/272474","InsertDate":"/Date(1606298335363)/","Priority":1,"isActive":true,"VisitCount":2},{"Id":707,"TestDate":13990914,"GroupCode":22,"TypeIndex":2,"TypeAction":"url","Title":"معرفی رشته بینایی سنجی","Description":"معرفی رشته بینایی سنجی از طریق گفت‌و‌گو با دانشجویان","FileUrl":"https://www.kanoon.ir/Article/272904","InsertDate":"/Date(1606819258800)/","Priority":1,"isActive":true,"VisitCount":2},{"Id":723,"TestDate":13990914,"GroupCode":22,"TypeIndex":2,"TypeAction":"url","Title":"مجله آزمون 14 آذر ","Description":"مجله آزمون 14 آذر ","FileUrl":"https://www.kanoon.ir/Downloads/Article/a8e48c59-72dd-4aea-8503-140e0514cdcb","InsertDate":"/Date(1606988042980)/","Priority":1,"isActive":true,"VisitCount":1}]}
/// Message : ""

GetTestToolBoxResponse getTestToolBoxResponseFromJson(String str) => GetTestToolBoxResponse.fromJson(json.decode(str));
String getTestToolBoxResponseToJson(GetTestToolBoxResponse data) => json.encode(data.toJson());
class GetTestToolBoxResponse {
  GetTestToolBoxResponse({
      num? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetTestToolBoxResponse.fromJson(dynamic json) {
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
/// testToolBox : [{"Id":696,"TestDate":13990914,"GroupCode":22,"TypeIndex":2,"TypeAction":"url","Title":"معرفی رشته علوم تغذیه","Description":"معرفی رشته علوم تغذیه از طریق گفت‌و‌گو با دانشجویان","FileUrl":"https://www.kanoon.ir/Article/272474","InsertDate":"/Date(1606298335363)/","Priority":1,"isActive":true,"VisitCount":2},{"Id":707,"TestDate":13990914,"GroupCode":22,"TypeIndex":2,"TypeAction":"url","Title":"معرفی رشته بینایی سنجی","Description":"معرفی رشته بینایی سنجی از طریق گفت‌و‌گو با دانشجویان","FileUrl":"https://www.kanoon.ir/Article/272904","InsertDate":"/Date(1606819258800)/","Priority":1,"isActive":true,"VisitCount":2},{"Id":723,"TestDate":13990914,"GroupCode":22,"TypeIndex":2,"TypeAction":"url","Title":"مجله آزمون 14 آذر ","Description":"مجله آزمون 14 آذر ","FileUrl":"https://www.kanoon.ir/Downloads/Article/a8e48c59-72dd-4aea-8503-140e0514cdcb","InsertDate":"/Date(1606988042980)/","Priority":1,"isActive":true,"VisitCount":1}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? state, 
      String? message, 
      List<TestToolBox>? testToolBox,}){
    _state = state;
    _message = message;
    _testToolBox = testToolBox;
}

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    if (json['testToolBox'] != null) {
      _testToolBox = [];
      json['testToolBox'].forEach((v) {
        _testToolBox?.add(TestToolBox.fromJson(v));
      });
    }
  }
  num? _state;
  String? _message;
  List<TestToolBox>? _testToolBox;

  num? get state => _state;
  String? get message => _message;
  List<TestToolBox>? get testToolBox => _testToolBox;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    if (_testToolBox != null) {
      map['testToolBox'] = _testToolBox?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Id : 696
/// TestDate : 13990914
/// GroupCode : 22
/// TypeIndex : 2
/// TypeAction : "url"
/// Title : "معرفی رشته علوم تغذیه"
/// Description : "معرفی رشته علوم تغذیه از طریق گفت‌و‌گو با دانشجویان"
/// FileUrl : "https://www.kanoon.ir/Article/272474"
/// InsertDate : "/Date(1606298335363)/"
/// Priority : 1
/// isActive : true
/// VisitCount : 2

TestToolBox testToolBoxFromJson(String str) => TestToolBox.fromJson(json.decode(str));
String testToolBoxToJson(TestToolBox data) => json.encode(data.toJson());
class TestToolBox {
  TestToolBox({
      num? id, 
      num? testDate, 
      num? groupCode, 
      num? typeIndex, 
      String? typeAction, 
      String? title, 
      String? description, 
      String? fileUrl, 
      String? insertDate, 
      num? priority, 
      bool? isActive, 
      num? visitCount,}){
    _id = id;
    _testDate = testDate;
    _groupCode = groupCode;
    _typeIndex = typeIndex;
    _typeAction = typeAction;
    _title = title;
    _description = description;
    _fileUrl = fileUrl;
    _insertDate = insertDate;
    _priority = priority;
    _isActive = isActive;
    _visitCount = visitCount;
}

  TestToolBox.fromJson(dynamic json) {
    _id = json['Id'];
    _testDate = json['TestDate'];
    _groupCode = json['GroupCode'];
    _typeIndex = json['TypeIndex'];
    _typeAction = json['TypeAction'];
    _title = json['Title'];
    _description = json['Description'];
    _fileUrl = json['FileUrl'];
    _insertDate = json['InsertDate'];
    _priority = json['Priority'];
    _isActive = json['isActive'];
    _visitCount = json['VisitCount'];
  }
  num? _id;
  num? _testDate;
  num? _groupCode;
  num? _typeIndex;
  String? _typeAction;
  String? _title;
  String? _description;
  String? _fileUrl;
  String? _insertDate;
  num? _priority;
  bool? _isActive;
  num? _visitCount;

  num? get id => _id;
  num? get testDate => _testDate;
  num? get groupCode => _groupCode;
  num? get typeIndex => _typeIndex;
  String? get typeAction => _typeAction;
  String? get title => _title;
  String? get description => _description;
  String? get fileUrl => _fileUrl;
  String? get insertDate => _insertDate;
  num? get priority => _priority;
  bool? get isActive => _isActive;
  num? get visitCount => _visitCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['TestDate'] = _testDate;
    map['GroupCode'] = _groupCode;
    map['TypeIndex'] = _typeIndex;
    map['TypeAction'] = _typeAction;
    map['Title'] = _title;
    map['Description'] = _description;
    map['FileUrl'] = _fileUrl;
    map['InsertDate'] = _insertDate;
    map['Priority'] = _priority;
    map['isActive'] = _isActive;
    map['VisitCount'] = _visitCount;
    return map;
  }

}