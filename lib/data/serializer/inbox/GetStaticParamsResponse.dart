import 'dart:convert';
GetStaticParamsResponse getStaticParamsResponseFromJson(String str) => GetStaticParamsResponse.fromJson(json.decode(str));
String getStaticParamsResponseToJson(GetStaticParamsResponse data) => json.encode(data.toJson());
class GetStaticParamsResponse {
  GetStaticParamsResponse({
      this.status, 
      this.data, 
      this.message,});

  GetStaticParamsResponse.fromJson(dynamic json) {
    status = json['Status'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    message = json['Message'];
  }
  num? status;
  Data? data;
  String? message;
GetStaticParamsResponse copyWith({  num? status,
  Data? data,
  String? message,
}) => GetStaticParamsResponse(  status: status ?? this.status,
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
      this.matchStartTime, 
      this.matchQuestionSecLength, 
      this.unSeenInboxCount, 
      this.user,});

  Data.fromJson(dynamic json) {
    state = json['state'];
    message = json['message'];
    matchStartTime = json['matchStartTime'];
    matchQuestionSecLength = json['matchQuestionSecLength'];
    unSeenInboxCount = json['UnSeenInboxCount'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  num? state;
  String? message;
  num? matchStartTime;
  num? matchQuestionSecLength;
  num? unSeenInboxCount;
  User? user;
Data copyWith({  num? state,
  String? message,
  num? matchStartTime,
  num? matchQuestionSecLength,
  num? unSeenInboxCount,
  User? user,
}) => Data(  state: state ?? this.state,
  message: message ?? this.message,
  matchStartTime: matchStartTime ?? this.matchStartTime,
  matchQuestionSecLength: matchQuestionSecLength ?? this.matchQuestionSecLength,
  unSeenInboxCount: unSeenInboxCount ?? this.unSeenInboxCount,
  user: user ?? this.user,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = state;
    map['message'] = message;
    map['matchStartTime'] = matchStartTime;
    map['matchQuestionSecLength'] = matchQuestionSecLength;
    map['UnSeenInboxCount'] = unSeenInboxCount;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      this.id, 
      this.counter, 
      this.activeRoles, 
      this.firstName, 
      this.lastName, 
      this.imei, 
      this.pusheId, 
      this.lastImei, 
      this.lastPusheId, 
      this.credit, 
      this.mobile, 
      this.groupCode, 
      this.groupName, 
      this.nationalCode, 
      this.sex, 
      this.cityCode, 
      this.stateCode, 
      this.roleId, 
      this.insertDate, 
      this.loginDate, 
      this.isValid, 
      this.areaCode, 
      this.officeCode, 
      this.passWord, 
      this.currentVersion, 
      this.recommender, 
      this.isIOS, 
      this.appPassword, 
      this.isActiveInCurrentYear, 
      this.cachePrize, 
      this.currentYear,});

  User.fromJson(dynamic json) {
    id = json['Id'];
    counter = json['Counter'];
    activeRoles = json['ActiveRoles'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    imei = json['Imei'];
    pusheId = json['PusheId'];
    lastImei = json['LastImei'];
    lastPusheId = json['LastPusheId'];
    credit = json['Credit'];
    mobile = json['Mobile'];
    groupCode = json['GroupCode'];
    groupName = json['GroupName'];
    nationalCode = json['NationalCode'];
    sex = json['Sex'];
    cityCode = json['CityCode'];
    stateCode = json['StateCode'];
    roleId = json['RoleId'];
    insertDate = json['InsertDate'];
    loginDate = json['LoginDate'];
    isValid = json['IsValid'];
    areaCode = json['AreaCode'];
    officeCode = json['OfficeCode'];
    passWord = json['PassWord'];
    currentVersion = json['CurrentVersion'];
    recommender = json['Recommender'];
    isIOS = json['IsIOS'];
    appPassword = json['AppPassword'];
    isActiveInCurrentYear = json['IsActiveInCurrentYear'];
    cachePrize = json['CachePrize'];
    currentYear = json['CurrentYear'];
  }
  num? id;
  num? counter;
  String? activeRoles;
  String? firstName;
  String? lastName;
  String? imei;
  String? pusheId;
  String? lastImei;
  String? lastPusheId;
  num? credit;
  String? mobile;
  num? groupCode;
  String? groupName;
  String? nationalCode;
  bool? sex;
  num? cityCode;
  num? stateCode;
  num? roleId;
  String? insertDate;
  String? loginDate;
  bool? isValid;
  num? areaCode;
  num? officeCode;
  String? passWord;
  num? currentVersion;
  num? recommender;
  bool? isIOS;
  String? appPassword;
  bool? isActiveInCurrentYear;
  num? cachePrize;
  num? currentYear;
User copyWith({  num? id,
  num? counter,
  String? activeRoles,
  String? firstName,
  String? lastName,
  String? imei,
  String? pusheId,
  String? lastImei,
  String? lastPusheId,
  num? credit,
  String? mobile,
  num? groupCode,
  String? groupName,
  String? nationalCode,
  bool? sex,
  num? cityCode,
  num? stateCode,
  num? roleId,
  String? insertDate,
  String? loginDate,
  bool? isValid,
  num? areaCode,
  num? officeCode,
  String? passWord,
  num? currentVersion,
  num? recommender,
  bool? isIOS,
  String? appPassword,
  bool? isActiveInCurrentYear,
  num? cachePrize,
  num? currentYear,
}) => User(  id: id ?? this.id,
  counter: counter ?? this.counter,
  activeRoles: activeRoles ?? this.activeRoles,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  imei: imei ?? this.imei,
  pusheId: pusheId ?? this.pusheId,
  lastImei: lastImei ?? this.lastImei,
  lastPusheId: lastPusheId ?? this.lastPusheId,
  credit: credit ?? this.credit,
  mobile: mobile ?? this.mobile,
  groupCode: groupCode ?? this.groupCode,
  groupName: groupName ?? this.groupName,
  nationalCode: nationalCode ?? this.nationalCode,
  sex: sex ?? this.sex,
  cityCode: cityCode ?? this.cityCode,
  stateCode: stateCode ?? this.stateCode,
  roleId: roleId ?? this.roleId,
  insertDate: insertDate ?? this.insertDate,
  loginDate: loginDate ?? this.loginDate,
  isValid: isValid ?? this.isValid,
  areaCode: areaCode ?? this.areaCode,
  officeCode: officeCode ?? this.officeCode,
  passWord: passWord ?? this.passWord,
  currentVersion: currentVersion ?? this.currentVersion,
  recommender: recommender ?? this.recommender,
  isIOS: isIOS ?? this.isIOS,
  appPassword: appPassword ?? this.appPassword,
  isActiveInCurrentYear: isActiveInCurrentYear ?? this.isActiveInCurrentYear,
  cachePrize: cachePrize ?? this.cachePrize,
  currentYear: currentYear ?? this.currentYear,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Counter'] = counter;
    map['ActiveRoles'] = activeRoles;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['Imei'] = imei;
    map['PusheId'] = pusheId;
    map['LastImei'] = lastImei;
    map['LastPusheId'] = lastPusheId;
    map['Credit'] = credit;
    map['Mobile'] = mobile;
    map['GroupCode'] = groupCode;
    map['GroupName'] = groupName;
    map['NationalCode'] = nationalCode;
    map['Sex'] = sex;
    map['CityCode'] = cityCode;
    map['StateCode'] = stateCode;
    map['RoleId'] = roleId;
    map['InsertDate'] = insertDate;
    map['LoginDate'] = loginDate;
    map['IsValid'] = isValid;
    map['AreaCode'] = areaCode;
    map['OfficeCode'] = officeCode;
    map['PassWord'] = passWord;
    map['CurrentVersion'] = currentVersion;
    map['Recommender'] = recommender;
    map['IsIOS'] = isIOS;
    map['AppPassword'] = appPassword;
    map['IsActiveInCurrentYear'] = isActiveInCurrentYear;
    map['CachePrize'] = cachePrize;
    map['CurrentYear'] = currentYear;
    return map;
  }

}