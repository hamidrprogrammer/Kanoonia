import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    num? id,
    num? counter,
    String? firstName,
    String? lastName,
    String? imei,
    String? pusheId,
    String? lastImei,
    String? lastPusheId,
    num? credit,
    String? mobile,
    String? code,
    num? groupCode,
    String? groupName,
    String? nationalCode,
    Object? sex,
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
  }) {
    _id = id;
    _counter = counter;
    _firstName = firstName;
    _lastName = lastName;
    _imei = imei;
    _pusheId = pusheId;
    _lastImei = lastImei;
    _lastPusheId = lastPusheId;
    _credit = credit;
    _mobile = mobile;
    _code = code;
    _groupCode = groupCode;
    _groupName = groupName;
    _nationalCode = nationalCode;
    _sex = sex;
    _cityCode = cityCode;
    _stateCode = stateCode;
    _roleId = roleId;
    _insertDate = insertDate;
    _loginDate = loginDate;
    _isValid = isValid;
    _areaCode = areaCode;
    _officeCode = officeCode;
    _passWord = passWord;
    _currentVersion = currentVersion;
    _recommender = recommender;
    _isIOS = isIOS;
    _appPassword = appPassword;
    _isActiveInCurrentYear = isActiveInCurrentYear;
    _cachePrize = cachePrize;
    _currentYear = currentYear;
  }

  User.fromJson(dynamic json) {
    _id = json['Id'];
    _counter = json['Counter'];
    _firstName = json['FirstName'];
    _lastName = json['LastName'];
    _imei = json['Imei'];
    _pusheId = json['PusheId'];
    _lastImei = json['LastImei'];
    _lastPusheId = json['LastPusheId'];
    _credit = json['Credit'];
    _mobile = json['Mobile'];
    _groupCode = json['GroupCode'];
    _groupName = json['GroupName'];
    _nationalCode = json['NationalCode'];
    _sex = json['Sex'];
    _cityCode = json['CityCode'];
    _stateCode = json['StateCode'];
    _roleId = json['RoleId'];
    _insertDate = json['InsertDate'];
    _loginDate = json['LoginDate'];
    _isValid = json['IsValid'];
    _areaCode = json['AreaCode'];
    _officeCode = json['OfficeCode'];
    _passWord = json['PassWord'];
    _currentVersion = json['CurrentVersion'];
    _recommender = json['Recommender'];
    _isIOS = json['IsIOS'];
    _appPassword = json['AppPassword'];
    _isActiveInCurrentYear = json['IsActiveInCurrentYear'];
    _cachePrize = json['CachePrize'];
    _currentYear = json['CurrentYear'];
  }

  num? _id;
  num? _counter;
  String? _firstName;
  String? _code;
  String? _lastName;
  String? _imei;
  String? _pusheId;
  String? _lastImei;
  String? _lastPusheId;
  num? _credit;
  String? _mobile;
  num? _groupCode;
  String? _groupName;
  String? _nationalCode;
  Object? _sex;
  num? _cityCode;
  num? _stateCode;
  num? _roleId;
  String? _insertDate;
  String? _loginDate;
  bool? _isValid;
  num? _areaCode;
  num? _officeCode;
  String? _passWord;
  num? _currentVersion;
  num? _recommender;
  bool? _isIOS;
  String? _appPassword;
  bool? _isActiveInCurrentYear;
  num? _cachePrize;
  num? _currentYear;

  num? get id => _id;

  num? get counter => _counter;

  String? get code => _code;

  set setCode(code) => _code = code;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get imei => _imei;

  String? get pusheId => _pusheId;

  String? get lastImei => _lastImei;

  String? get lastPusheId => _lastPusheId;

  num? get credit => _credit;

  String? get mobile => _mobile;

  num? get groupCode => _groupCode;

  String? get groupName => _groupName;

  String? get nationalCode => _nationalCode;

  Object? get sex => _sex;

  num? get cityCode => _cityCode;

  num? get stateCode => _stateCode;

  num? get roleId => _roleId;

  String? get insertDate => _insertDate;

  String? get loginDate => _loginDate;

  bool? get isValid => _isValid;

  num? get areaCode => _areaCode;

  num? get officeCode => _officeCode;

  String? get passWord => _passWord;

  num? get currentVersion => _currentVersion;

  num? get recommender => _recommender;

  bool? get isIOS => _isIOS;

  String? get appPassword => _appPassword;

  bool? get isActiveInCurrentYear => _isActiveInCurrentYear;

  num? get cachePrize => _cachePrize;

  num? get currentYear => _currentYear;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['Counter'] = _counter;
    map['FirstName'] = _firstName;
    map['LastName'] = _lastName;
    map['Imei'] = _imei;
    map['PusheId'] = _pusheId;
    map['LastImei'] = _lastImei;
    map['LastPusheId'] = _lastPusheId;
    map['Credit'] = _credit;
    map['Mobile'] = _mobile;
    map['GroupCode'] = _groupCode;
    map['GroupName'] = _groupName;
    map['NationalCode'] = _nationalCode;
    map['Sex'] = _sex;
    map['CityCode'] = _cityCode;
    map['StateCode'] = _stateCode;
    map['RoleId'] = _roleId;
    map['InsertDate'] = _insertDate;
    map['LoginDate'] = _loginDate;
    map['IsValid'] = _isValid;
    map['AreaCode'] = _areaCode;
    map['OfficeCode'] = _officeCode;
    map['PassWord'] = _passWord;
    map['CurrentVersion'] = _currentVersion;
    map['Recommender'] = _recommender;
    map['IsIOS'] = _isIOS;
    map['AppPassword'] = _appPassword;
    map['IsActiveInCurrentYear'] = _isActiveInCurrentYear;
    map['CachePrize'] = _cachePrize;
    map['CurrentYear'] = _currentYear;
    return map;
  }
}
