import 'dart:convert';
/// Status : 1
/// Data : {"state":1,"activationCode":617866,"message":"Sent activation code sms"}
/// Message : null

ForgetPasswordResponse forgetPasswordResponseFromJson(String str) => ForgetPasswordResponse.fromJson(json.decode(str));
String forgetPasswordResponseToJson(ForgetPasswordResponse data) => json.encode(data.toJson());
class ForgetPasswordResponse {
  ForgetPasswordResponse({
      num? status, 
      Data? data, 
      dynamic message,}){
    _status = status;
    _data = data;
    _message = message;
}

  ForgetPasswordResponse.fromJson(dynamic json) {
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
/// activationCode : 617866
/// message : "Sent activation code sms"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? state, 
      num? activationCode, 
      String? message,}){
    _state = state;
    _activationCode = activationCode;
    _message = message;
}

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _activationCode = json['activationCode'];
    _message = json['message'];
  }
  num? _state;
  num? _activationCode;
  String? _message;

  num? get state => _state;
  num? get activationCode => _activationCode;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['activationCode'] = _activationCode;
    map['message'] = _message;
    return map;
  }

}