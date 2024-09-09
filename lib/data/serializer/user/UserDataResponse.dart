import 'dart:convert';
UserDataResponse userDataResponseFromJson(String str) => UserDataResponse.fromJson(json.decode(str));
String userDataResponseToJson(UserDataResponse data) => json.encode(data.toJson());
class UserDataResponse {
  UserDataResponse({
      this.counter, 
      this.testDate, 
      this.success, 
      this.responseMessage,});

  UserDataResponse.fromJson(dynamic json) {
    counter = json['Counter'];
    testDate = json['TestDate'];
    success = json['Success'];
    responseMessage = json['ResponseMessage'];
  }
  num? counter;
  num? testDate;
  bool? success;
  String? responseMessage;
UserDataResponse copyWith({  num? counter,
  num? testDate,
  bool? success,
  String? responseMessage,
}) => UserDataResponse(  counter: counter ?? this.counter,
  testDate: testDate ?? this.testDate,
  success: success ?? this.success,
  responseMessage: responseMessage ?? this.responseMessage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Counter'] = counter;
    map['TestDate'] = testDate;
    map['Success'] = success;
    map['ResponseMessage'] = responseMessage;
    return map;
  }

}