import 'dart:convert';
GetAppSupportKindsResponse getAppSupportKindsResponseFromJson(String str) => GetAppSupportKindsResponse.fromJson(json.decode(str));
String getAppSupportKindsResponseToJson(GetAppSupportKindsResponse data) => json.encode(data.toJson());
class GetAppSupportKindsResponse {
  GetAppSupportKindsResponse({
      this.status, 
      this.data, 
      this.message,});

  GetAppSupportKindsResponse.fromJson(dynamic json) {
    status = json['Status'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    message = json['Message'];
  }
  num? status;
  Data? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
    map['Message'] = message;
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.state, 
      this.message, 
      this.requestKindsList,});

  Data.fromJson(dynamic json) {
    state = json['state'];
    message = json['message'];
    if (json['requestKindsList'] != null) {
      requestKindsList = [];
      json['requestKindsList'].forEach((v) {
        requestKindsList?.add(RequestKindsList.fromJson(v));
      });
    }
  }
  num? state;
  String? message;
  List<RequestKindsList>? requestKindsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = state;
    map['message'] = message;
    if (requestKindsList != null) {
      map['requestKindsList'] = requestKindsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

RequestKindsList requestKindsListFromJson(String str) => RequestKindsList.fromJson(json.decode(str));
String requestKindsListToJson(RequestKindsList data) => json.encode(data.toJson());
class RequestKindsList {
  RequestKindsList({
      this.requestKindId, 
      this.title,});

  RequestKindsList.fromJson(dynamic json) {
    requestKindId = json['RequestKindId'];
    title = json['Title'];
  }
  num? requestKindId;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RequestKindId'] = requestKindId;
    map['Title'] = title;
    return map;
  }

}