import 'dart:convert';

CheckForPollResponse checkForPollResponseFromJson(String str) =>
    CheckForPollResponse.fromJson(json.decode(str));

String checkForPollResponseToJson(CheckForPollResponse data) =>
    json.encode(data.toJson());

class CheckForPollResponse {
  CheckForPollResponse({
    this.status,
    this.data,
    this.message,
  });

  CheckForPollResponse.fromJson(dynamic json) {
    status = json['Status'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    message = json['Message'];
  }

  int? status;
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
    this.pollUrl,
  });

  Data.fromJson(dynamic json) {
    state = json['state'];
    message = json['message'];
    if (json['pollUrl'] != null) {
      pollUrl = PollUrl.fromJson(json['pollUrl']);
    }
  }

  int? state;
  String? message;
  PollUrl? pollUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = state;
    map['message'] = message;
    if (pollUrl != null) {
      map['pollUrl'] = pollUrl?.toJson();
    }
    return map;
  }
}

PollUrl pollUrlFromJson(String str) => PollUrl.fromJson(json.decode(str));

String pollUrlToJson(PollUrl data) => json.encode(data.toJson());

class PollUrl {
  PollUrl({
    this.id,
    this.code,
    this.pollId,
    this.url,
    this.shortUrl,
  });

  PollUrl.fromJson(dynamic json) {
    id = json['Id'];
    code = json['Code'];
    pollId = json['PollId'];
    url = json['Url'];
    shortUrl = json['ShortUrl'];
  }

  int? id;
  String? code;
  int? pollId;
  String? url;
  String? shortUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Code'] = code;
    map['PollId'] = pollId;
    map['Url'] = url;
    map['ShortUrl'] = shortUrl;
    return map;
  }
}
