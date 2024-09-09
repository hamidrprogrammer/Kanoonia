import 'dart:convert';
/// Status : 1
/// Data : {"state":1,"message":"جستجوی انواع کارنامه ها با موفقیت انجام شد","kinds":[{"name":"کارنامه مقایسه ای","id":0},{"name":"کارنامه اصلی","id":1}]}
/// Message : ""

GetWorkBookKindsResponse getWorkBookKindsResponseFromJson(String str) => GetWorkBookKindsResponse.fromJson(json.decode(str));
String getWorkBookKindsResponseToJson(GetWorkBookKindsResponse data) => json.encode(data.toJson());
class GetWorkBookKindsResponse {
  GetWorkBookKindsResponse({
      num? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetWorkBookKindsResponse.fromJson(dynamic json) {
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
/// message : "جستجوی انواع کارنامه ها با موفقیت انجام شد"
/// kinds : [{"name":"کارنامه مقایسه ای","id":0},{"name":"کارنامه اصلی","id":1}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? state, 
      String? message, 
      List<Kinds>? kinds,}){
    _state = state;
    _message = message;
    _kinds = kinds;
}

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    if (json['kinds'] != null) {
      _kinds = [];
      json['kinds'].forEach((v) {
        _kinds?.add(Kinds.fromJson(v));
      });
    }
  }
  num? _state;
  String? _message;
  List<Kinds>? _kinds;

  num? get state => _state;
  String? get message => _message;
  List<Kinds>? get kinds => _kinds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    if (_kinds != null) {
      map['kinds'] = _kinds?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "کارنامه مقایسه ای"
/// id : 0

Kinds kindsFromJson(String str) => Kinds.fromJson(json.decode(str));
String kindsToJson(Kinds data) => json.encode(data.toJson());
class Kinds {
  Kinds({
      String? name, 
      num? id,}){
    _name = name;
    _id = id;
}

  Kinds.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
  }
  String? _name;
  num? _id;

  String? get name => _name;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    return map;
  }

}