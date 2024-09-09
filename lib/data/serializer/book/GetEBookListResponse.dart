import 'dart:convert';
/// Status : 1
/// Data : {"state":1,"message":"اطلاعات با موفقیت ارسال شد","EBookList":[{"BookId":108,"BookCode":1400007,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 3","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_3.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_3.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false},{"BookId":109,"BookCode":1400008,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 4","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_4.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_4.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false},{"BookId":110,"BookCode":1400009,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 1","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_1.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_1.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false},{"BookId":111,"BookCode":1400010,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 2","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_2.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_2.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false},{"BookId":112,"BookCode":1400011,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 5","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_5.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_5.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false},{"BookId":113,"BookCode":1400012,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 6","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_6.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_6.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false}]}
/// Message : ""

GetEBookListResponse getEBookListResponseFromJson(String str) => GetEBookListResponse.fromJson(json.decode(str));
String getEBookListResponseToJson(GetEBookListResponse data) => json.encode(data.toJson());
class GetEBookListResponse {
  GetEBookListResponse({
      num? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetEBookListResponse.fromJson(dynamic json) {
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
/// message : "اطلاعات با موفقیت ارسال شد"
/// EBookList : [{"BookId":108,"BookCode":1400007,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 3","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_3.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_3.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false},{"BookId":109,"BookCode":1400008,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 4","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_4.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_4.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false},{"BookId":110,"BookCode":1400009,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 1","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_1.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_1.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false},{"BookId":111,"BookCode":1400010,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 2","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_2.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_2.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false},{"BookId":112,"BookCode":1400011,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 5","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_5.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_5.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false},{"BookId":113,"BookCode":1400012,"BookName":"آزمون سکوی صفر کتاب جمع بندی پایه - شماره 6","FilePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_6.pdf?id=1","BookImagePath":"https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_6.png?id=1","Amount":15000,"ExpirationDays":100,"IsOpen":false}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? state, 
      String? message, 
      List<EBookList>? eBookList,}){
    _state = state;
    _message = message;
    _eBookList = eBookList;
}

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    if (json['EBookList'] != null) {
      _eBookList = [];
      json['EBookList'].forEach((v) {
        _eBookList?.add(EBookList.fromJson(v));
      });
    }
  }
  num? _state;
  String? _message;
  List<EBookList>? _eBookList;

  num? get state => _state;
  String? get message => _message;
  List<EBookList>? get eBookList => _eBookList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    if (_eBookList != null) {
      map['EBookList'] = _eBookList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// BookId : 108
/// BookCode : 1400007
/// BookName : "آزمون سکوی صفر کتاب جمع بندی پایه - شماره 3"
/// FilePath : "https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/PDF/22_3.pdf?id=1"
/// BookImagePath : "https://appservice.kanoon.ir/Files/Kanooniha/EBook/BookType1/Image/22_3.png?id=1"
/// Amount : 15000
/// ExpirationDays : 100
/// IsOpen : false

EBookList eBookListFromJson(String str) => EBookList.fromJson(json.decode(str));
String eBookListToJson(EBookList data) => json.encode(data.toJson());
class EBookList {
  EBookList({
      num? bookId, 
      num? bookCode, 
      String? bookName, 
      String? filePath, 
      String? bookImagePath, 
      num? amount, 
      num? expirationDays, 
      bool? isOpen,}){
    _bookId = bookId;
    _bookCode = bookCode;
    _bookName = bookName;
    _filePath = filePath;
    _bookImagePath = bookImagePath;
    _amount = amount;
    _expirationDays = expirationDays;
    _isOpen = isOpen;
}

  EBookList.fromJson(dynamic json) {
    _bookId = json['BookId'];
    _bookCode = json['BookCode'];
    _bookName = json['BookName'];
    _filePath = json['FilePath'];
    _bookImagePath = json['BookImagePath'];
    _amount = json['Amount'];
    _expirationDays = json['ExpirationDays'];
    _isOpen = json['IsOpen'];
  }
  num? _bookId;
  num? _bookCode;
  String? _bookName;
  String? _filePath;
  String? _bookImagePath;
  num? _amount;
  num? _expirationDays;
  bool? _isOpen;

  num? get bookId => _bookId;
  num? get bookCode => _bookCode;
  String? get bookName => _bookName;
  String? get filePath => _filePath;
  String? get bookImagePath => _bookImagePath;
  num? get amount => _amount;
  num? get expirationDays => _expirationDays;
  bool? get isOpen => _isOpen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BookId'] = _bookId;
    map['BookCode'] = _bookCode;
    map['BookName'] = _bookName;
    map['FilePath'] = _filePath;
    map['BookImagePath'] = _bookImagePath;
    map['Amount'] = _amount;
    map['ExpirationDays'] = _expirationDays;
    map['IsOpen'] = _isOpen;
    return map;
  }

}