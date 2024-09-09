import 'dart:convert';
UpdateResponse updateResponseFromJson(String str) => UpdateResponse.fromJson(json.decode(str));
String updateResponseToJson(UpdateResponse data) => json.encode(data.toJson());
class UpdateResponse {
  UpdateResponse({
      this.status, 
      this.data, 
      this.message,});

  UpdateResponse.fromJson(dynamic json) {
    status = json['Status'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    message = json['Message'];
  }
  num? status;
  Data? data;
  String? message;
UpdateResponse copyWith({  num? status,
  Data? data,
  String? message,
}) => UpdateResponse(  status: status ?? this.status,
  data: data ?? this.data,
  message: message ?? this.message,
);
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
      this.isForceUpdate,
      this.link,});

  Data.fromJson(dynamic json) {
    state = json['state'];
    message = json['message'];
    link = json['link'];
    isForceUpdate = json['isForceUpdate'];
  }
  num? state;
  String? message;
  String? link;
  bool? isForceUpdate;
Data copyWith({  num? state,
  String? message,
  String? link,
}) => Data(  state: state ?? this.state,
  message: message ?? this.message,
  link: link ?? this.link,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = state;
    map['message'] = message;
    map['link'] = link;
    return map;
  }

}