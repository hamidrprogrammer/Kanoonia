import 'dart:convert';

import 'User.dart';

/// Status : 1
/// Data : {"state":1,"message":"ثبت نام کاربر غیر کانونی با موفقیت انجام شد.","id":336427,"user":{"Id":336427,"Counter":123,"FirstName":"Fatemeh","LastName":"Alagheband","Imei":"","PusheId":"","LastImei":"","LastPusheId":"","Credit":0,"Mobile":"09123456789","GroupCode":46,"GroupName":"دوم دبستان","NationalCode":"0022665588","Sex":0,"CityCode":17001,"StateCode":17,"RoleId":7,"InsertDate":"/Date(1604917053473)/","LoginDate":"/Date(1604917053473)/","IsValid":false,"AreaCode":123,"OfficeCode":12,"PassWord":"","CurrentVersion":41,"Recommender":"","IsIOS":false,"AppPassword":"0022665588","IsActiveInCurrentYear":true,"CachePrize":0,"CurrentYear":100}}
/// Message : ""

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    num? status,
    Data? data,
    String? message,
  }) {
    _status = status;
    _data = data;
    _message = message;
  }

  RegisterResponse.fromJson(dynamic json) {
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
/// message : "ثبت نام کاربر غیر کانونی با موفقیت انجام شد."
/// id : 336427
/// user : {"Id":336427,"Counter":123,"FirstName":"Fatemeh","LastName":"Alagheband","Imei":"","PusheId":"","LastImei":"","LastPusheId":"","Credit":0,"Mobile":"09123456789","GroupCode":46,"GroupName":"دوم دبستان","NationalCode":"0022665588","Sex":0,"CityCode":17001,"StateCode":17,"RoleId":7,"InsertDate":"/Date(1604917053473)/","LoginDate":"/Date(1604917053473)/","IsValid":false,"AreaCode":123,"OfficeCode":12,"PassWord":"","CurrentVersion":41,"Recommender":"","IsIOS":false,"AppPassword":"0022665588","IsActiveInCurrentYear":true,"CachePrize":0,"CurrentYear":100}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? state,
    String? message,
    num? id,
    num? activationCode,
    User? user,
  }) {
    _state = state;
    _message = message;
    _id = id;
    _user = user;
    _activationCode = activationCode;
  }

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    _activationCode = json['activationCode'];
    _id = json['id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  num? _state;
  String? _message;
  num? _id;
  User? _user;
  num? _activationCode;

  num? get state => _state;

  String? get message => _message;

  num? get activationCode => _activationCode;

  num? get id => _id;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    map['id'] = _id;
    map['activationCode'] = _activationCode;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

/// Id : 336427
/// Counter : 123
/// FirstName : "Fatemeh"
/// LastName : "Alagheband"
/// Imei : ""
/// PusheId : ""
/// LastImei : ""
/// LastPusheId : ""
/// Credit : 0
/// Mobile : "09123456789"
/// GroupCode : 46
/// GroupName : "دوم دبستان"
/// NationalCode : "0022665588"
/// Sex : 0
/// CityCode : 17001
/// StateCode : 17
/// RoleId : 7
/// InsertDate : "/Date(1604917053473)/"
/// LoginDate : "/Date(1604917053473)/"
/// IsValid : false
/// AreaCode : 123
/// OfficeCode : 12
/// PassWord : ""
/// CurrentVersion : 41
/// Recommender : ""
/// IsIOS : false
/// AppPassword : "0022665588"
/// IsActiveInCurrentYear : true
/// CachePrize : 0
/// CurrentYear : 100
