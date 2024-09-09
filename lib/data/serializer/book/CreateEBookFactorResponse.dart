import 'dart:convert';
/// Status : 1
/// Data : {"status":1,"message":"لینک خرید با موفقیت ارسال شد.","EBookFactorId":3845,"BankUrl":"https://pay.sdts.ir/Pay/77ef076c826d437cae0f0e80982286c6"}
/// Message : ""

CreateEBookFactorResponse createEBookFactorResponseFromJson(String str) => CreateEBookFactorResponse.fromJson(json.decode(str));
String createEBookFactorResponseToJson(CreateEBookFactorResponse data) => json.encode(data.toJson());
class CreateEBookFactorResponse {
  CreateEBookFactorResponse({
      num? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  CreateEBookFactorResponse.fromJson(dynamic json) {
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

/// status : 1
/// message : "لینک خرید با موفقیت ارسال شد."
/// EBookFactorId : 3845
/// BankUrl : "https://pay.sdts.ir/Pay/77ef076c826d437cae0f0e80982286c6"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? status, 
      String? message, 
      num? eBookFactorId, 
      String? bankUrl,}){
    _status = status;
    _message = message;
    _eBookFactorId = eBookFactorId;
    _bankUrl = bankUrl;
}

  Data.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _eBookFactorId = json['EBookFactorId'];
    _bankUrl = json['BankUrl'];
  }
  num? _status;
  String? _message;
  num? _eBookFactorId;
  String? _bankUrl;

  num? get status => _status;
  String? get message => _message;
  num? get eBookFactorId => _eBookFactorId;
  String? get bankUrl => _bankUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['EBookFactorId'] = _eBookFactorId;
    map['BankUrl'] = _bankUrl;
    return map;
  }

}