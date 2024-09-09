import 'dart:convert';

FetchAllMessagesListResponse fetchAllMessagesListResponseFromJson(String str) =>
    FetchAllMessagesListResponse.fromJson(json.decode(str));

String fetchAllMessagesListResponseToJson(FetchAllMessagesListResponse data) =>
    json.encode(data.toJson());

class FetchAllMessagesListResponse {
  FetchAllMessagesListResponse({
    this.status,
    this.data,
    this.message,
  });

  FetchAllMessagesListResponse.fromJson(dynamic json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(MessengerItem.fromJson(v));
      });
    }
    message = json['Message'];
  }

  num? status;
  List<MessengerItem>? data;
  String? message;

  FetchAllMessagesListResponse copyWith({
    num? status,
    List<MessengerItem>? data,
    String? message,
  }) =>
      FetchAllMessagesListResponse(
        status: status ?? this.status,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    map['Message'] = message;
    return map;
  }
}

MessengerItem dataFromJson(String str) =>
    MessengerItem.fromJson(json.decode(str));

String dataToJson(MessengerItem data) => json.encode(data.toJson());

class MessengerItem {
  MessengerItem({
    this.id,
    this.oName,
    this.oFamily,
    this.title,
    this.message,
    this.messageReference,
    this.messageKind,
    this.insertDate,
    this.filePath,
    this.hasSeen,
  });

  MessengerItem.fromJson(dynamic json) {
    id = json['Id'];
    oName = json['oName'];
    oFamily = json['oFamily'];
    title = json['Title'];
    message = json['Message'];
    messageReference = json['MessageReference'];
    messageKind = json['MessageKind'];
    insertDate = json['InsertDate'];
    filePath = json['FilePath'];
    hasSeen = json['HasSeen'];
  }

  num? id;
  String? oName;
  String? oFamily;
  String? title;
  String? message;
  num? messageReference;
  num? messageKind;
  String? insertDate;
  String? filePath;
  bool? hasSeen;

  MessengerItem copyWith({
    num? id,
    String? oName,
    String? oFamily,
    String? title,
    String? message,
    num? messageReference,
    num? messageKind,
    String? insertDate,
    String? filePath,
  }) =>
      MessengerItem(
        id: id ?? this.id,
        oName: oName ?? this.oName,
        oFamily: oFamily ?? this.oFamily,
        title: title ?? this.title,
        message: message ?? this.message,
        messageReference: messageReference ?? this.messageReference,
        messageKind: messageKind ?? this.messageKind,
        insertDate: insertDate ?? this.insertDate,
        filePath: filePath ?? this.filePath,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['oName'] = oName;
    map['oFamily'] = oFamily;
    map['Title'] = title;
    map['Message'] = message;
    map['MessageReference'] = messageReference;
    map['MessageKind'] = messageKind;
    map['InsertDate'] = insertDate;
    map['FilePath'] = filePath;
    return map;
  }
}
