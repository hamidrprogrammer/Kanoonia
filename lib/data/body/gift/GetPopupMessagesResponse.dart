import 'dart:convert';
GetPopupMessagesResponse getPopupMessagesResponseFromJson(String str) => GetPopupMessagesResponse.fromJson(json.decode(str));
String getPopupMessagesResponseToJson(GetPopupMessagesResponse data) => json.encode(data.toJson());
class GetPopupMessagesResponse {
  GetPopupMessagesResponse({
      this.status, 
      this.data, 
      this.message,});

  GetPopupMessagesResponse.fromJson(dynamic json) {
    status = json['Status'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    message = json['Message'];
  }
  num? status;
  Data? data;
  String? message;
GetPopupMessagesResponse copyWith({  num? status,
  Data? data,
  String? message,
}) => GetPopupMessagesResponse(  status: status ?? this.status,
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
      this.popupMessage,});

  Data.fromJson(dynamic json) {
    state = json['state'];
    message = json['message'];
    popupMessage = json['PopupMessage'] != null ? PopupMessage.fromJson(json['PopupMessage']) : null;
  }
  num? state;
  String? message;
  PopupMessage? popupMessage;
Data copyWith({  num? state,
  String? message,
  PopupMessage? popupMessage,
}) => Data(  state: state ?? this.state,
  message: message ?? this.message,
  popupMessage: popupMessage ?? this.popupMessage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = state;
    map['message'] = message;
    if (popupMessage != null) {
      map['PopupMessage'] = popupMessage?.toJson();
    }
    return map;
  }

}

PopupMessage popupMessageFromJson(String str) => PopupMessage.fromJson(json.decode(str));
String popupMessageToJson(PopupMessage data) => json.encode(data.toJson());
class PopupMessage {
  PopupMessage({
      this.id, 
      this.appId, 
      this.title, 
      this.description,});

  PopupMessage.fromJson(dynamic json) {
    id = json['Id'];
    appId = json['AppId'];
    title = json['Title'];
    description = json['Description'];
  }
  num? id;
  num? appId;
  String? title;
  String? description;
PopupMessage copyWith({  num? id,
  num? appId,
  String? title,
  String? description,
}) => PopupMessage(  id: id ?? this.id,
  appId: appId ?? this.appId,
  title: title ?? this.title,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['AppId'] = appId;
    map['Title'] = title;
    map['Description'] = description;
    return map;
  }

}