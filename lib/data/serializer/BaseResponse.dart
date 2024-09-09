import 'dart:convert';
/// Status : 1
/// Data : {"state":1,"message":"با موفقیت افزوده شد"}
/// Message : ""

BaseResponse baseResponseFromJson(String str) => BaseResponse.fromJson(json.decode(str));
String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());
class BaseResponse {
  BaseResponse({
      num? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  BaseResponse.fromJson(dynamic json) {
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
/// message : "با موفقیت افزوده شد"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? state, 
      String? message,}){
    _state = state;
    _message = message;
}

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
  }
  num? _state;
  String? _message;

  num? get state => _state;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    return map;
  }

}