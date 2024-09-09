import 'dart:convert';
/// Status : 1
/// Data : {"state":1,"message":"","comment":{"Id":1173,"Counter":973450518,"AreaCode":3450,"OfficeCode":23,"TestDate":13990830,"CurrentYear":100,"WorkBookComment":"سلام ازمون بسیار خوبی بود واست از نظرهای مختلف\nهم تعادلش خوب بود و هم تعداد غلطها پایینتر و هم دروس انتخابی متعادلتر بودی\nو این یعنی تلاش کردی و خسته نباشی\nسلی کن تو برنامت هر روز تستهای فیزیک باشه","insertDate":"/Date(1605911160123)/","hasSeen":true,"visitCount":1}}
/// Message : ""

GetWorkBookCommentResponse getWorkBookCommentResponseFromJson(String str) => GetWorkBookCommentResponse.fromJson(json.decode(str));
String getWorkBookCommentResponseToJson(GetWorkBookCommentResponse data) => json.encode(data.toJson());
class GetWorkBookCommentResponse {
  GetWorkBookCommentResponse({
      num? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetWorkBookCommentResponse.fromJson(dynamic json) {
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
/// comment : {"Id":1173,"Counter":973450518,"AreaCode":3450,"OfficeCode":23,"TestDate":13990830,"CurrentYear":100,"WorkBookComment":"سلام ازمون بسیار خوبی بود واست از نظرهای مختلف\nهم تعادلش خوب بود و هم تعداد غلطها پایینتر و هم دروس انتخابی متعادلتر بودی\nو این یعنی تلاش کردی و خسته نباشی\nسلی کن تو برنامت هر روز تستهای فیزیک باشه","insertDate":"/Date(1605911160123)/","hasSeen":true,"visitCount":1}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? state, 
      String? message, 
      Comment? comment,}){
    _state = state;
    _message = message;
    _comment = comment;
}

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    _comment = json['comment'] != null ? Comment.fromJson(json['comment']) : null;
  }
  num? _state;
  String? _message;
  Comment? _comment;

  num? get state => _state;
  String? get message => _message;
  Comment? get comment => _comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    if (_comment != null) {
      map['comment'] = _comment?.toJson();
    }
    return map;
  }

}

/// Id : 1173
/// Counter : 973450518
/// AreaCode : 3450
/// OfficeCode : 23
/// TestDate : 13990830
/// CurrentYear : 100
/// WorkBookComment : "سلام ازمون بسیار خوبی بود واست از نظرهای مختلف\nهم تعادلش خوب بود و هم تعداد غلطها پایینتر و هم دروس انتخابی متعادلتر بودی\nو این یعنی تلاش کردی و خسته نباشی\nسلی کن تو برنامت هر روز تستهای فیزیک باشه"
/// insertDate : "/Date(1605911160123)/"
/// hasSeen : true
/// visitCount : 1

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));
String commentToJson(Comment data) => json.encode(data.toJson());
class Comment {
  Comment({
      num? id, 
      num? counter, 
      num? areaCode, 
      num? officeCode, 
      num? testDate, 
      num? currentYear, 
      String? workBookComment, 
      String? insertDate, 
      bool? hasSeen, 
      num? visitCount,}){
    _id = id;
    _counter = counter;
    _areaCode = areaCode;
    _officeCode = officeCode;
    _testDate = testDate;
    _currentYear = currentYear;
    _workBookComment = workBookComment;
    _insertDate = insertDate;
    _hasSeen = hasSeen;
    _visitCount = visitCount;
}

  Comment.fromJson(dynamic json) {
    _id = json['Id'];
    _counter = json['Counter'];
    _areaCode = json['AreaCode'];
    _officeCode = json['OfficeCode'];
    _testDate = json['TestDate'];
    _currentYear = json['CurrentYear'];
    _workBookComment = json['WorkBookComment'];
    _insertDate = json['insertDate'];
    _hasSeen = json['hasSeen'];
    _visitCount = json['visitCount'];
  }
  num? _id;
  num? _counter;
  num? _areaCode;
  num? _officeCode;
  num? _testDate;
  num? _currentYear;
  String? _workBookComment;
  String? _insertDate;
  bool? _hasSeen;
  num? _visitCount;

  num? get id => _id;
  num? get counter => _counter;
  num? get areaCode => _areaCode;
  num? get officeCode => _officeCode;
  num? get testDate => _testDate;
  num? get currentYear => _currentYear;
  String? get workBookComment => _workBookComment;
  String? get insertDate => _insertDate;
  bool? get hasSeen => _hasSeen;
  num? get visitCount => _visitCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['Counter'] = _counter;
    map['AreaCode'] = _areaCode;
    map['OfficeCode'] = _officeCode;
    map['TestDate'] = _testDate;
    map['CurrentYear'] = _currentYear;
    map['WorkBookComment'] = _workBookComment;
    map['insertDate'] = _insertDate;
    map['hasSeen'] = _hasSeen;
    map['visitCount'] = _visitCount;
    return map;
  }

}