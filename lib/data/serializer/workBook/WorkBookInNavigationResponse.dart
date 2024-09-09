import 'dart:convert';

WorkBookInNavigationResponse workBookInNavigationResponseFromJson(String str) =>
    WorkBookInNavigationResponse.fromJson(json.decode(str));

String workBookInNavigationResponseToJson(WorkBookInNavigationResponse data) =>
    json.encode(data.toJson());

class WorkBookInNavigationResponse {
  WorkBookInNavigationResponse({
    this.overviewWorkBook,
    this.workBookCourseDetailList,
    this.date,
  });

  WorkBookInNavigationResponse.fromJson(dynamic json) {
    overviewWorkBook = json['overviewWorkBook'] != null
        ? OverviewWorkBook.fromJson(json['overviewWorkBook'])
        : null;
    if (json['workBookCourseDetailList'] != null) {
      workBookCourseDetailList = [];
      json['workBookCourseDetailList'].forEach((v) {
        workBookCourseDetailList?.add(WorkBookCourseDetailList.fromJson(v));
      });
    }
  }

  OverviewWorkBook? overviewWorkBook;
  List<WorkBookCourseDetailList>? workBookCourseDetailList;
  String? date;

  WorkBookInNavigationResponse copyWith({
    OverviewWorkBook? overviewWorkBook,
    List<WorkBookCourseDetailList>? workBookCourseDetailList,
  }) =>
      WorkBookInNavigationResponse(
        overviewWorkBook: overviewWorkBook ?? this.overviewWorkBook,
        workBookCourseDetailList:
            workBookCourseDetailList ?? this.workBookCourseDetailList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (overviewWorkBook != null) {
      map['overviewWorkBook'] = overviewWorkBook?.toJson();
    }
    if (workBookCourseDetailList != null) {
      map['workBookCourseDetailList'] =
          workBookCourseDetailList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

WorkBookCourseDetailList workBookCourseDetailListFromJson(String str) =>
    WorkBookCourseDetailList.fromJson(json.decode(str));

String workBookCourseDetailListToJson(WorkBookCourseDetailList data) =>
    json.encode(data.toJson());

class WorkBookCourseDetailList {
  WorkBookCourseDetailList({
    this.groupCode,
    this.counter,
    this.rowId,
    this.groupId,
    this.groupName,
    this.courseId,
    this.courseName,
    this.isPack,
    this.show,
    this.isSpecial,
    this.style,
    this.startPos,
    this.required,
    this.cofficient,
    this.cofficients,
    this.sigma,
    this.avgPercent,
    this.stdCount,
    this.avgPoint,
    this.maxPercent,
    this.maxPoint,
    this.computedLevel,
    this.tarazZero,
    this.kind,
    this.swapRow,
    this.location,
    this.dpercent,
    this.dpercentStr,
    this.dpercentNFrom10,
    this.dlevel,
    this.normallevel,
    this.dpoint,
    this.dpointStr,
    this.dpointNFrom10,
    this.dRank,
    this.decile,
    this.decileStr,
    this.dQuestionCnt,
    this.dCorrect,
    this.dWrong,
    this.dWhite,
    this.n10,
    this.n10Number,
    this.n10Same,
    this.abcdindex,
    this.minLevel,
    this.minLevelPositivePercent,
    this.maxLevel,
    this.lastRank,
    this.dEasyCorrect,
    this.dEasyWrong,
    this.dEasyWhite,
    this.dEasyQuestions,
    this.dEasyCount,
    this.dEasyNoneTrueCount,
    this.dEasyStr,
    this.workbookGridLocation,
  });

  WorkBookCourseDetailList.fromJson(dynamic json) {
    groupCode = json['groupCode'];
    counter = json['counter'];
    rowId = json['rowId'];
    groupId = json['groupId'];
    groupName = json['groupName'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    isPack = json['isPack'];
    show = json['show'];
    isSpecial = json['isSpecial'];
    style = json['style'];
    startPos = json['startPos'];
    required = json['required'];
    cofficient = json['cofficient'];
    cofficients = json['cofficients'];
    sigma = json['sigma'];
    avgPercent = json['avgPercent'];
    stdCount = json['stdCount'];
    avgPoint = json['avgPoint'];
    maxPercent = json['maxPercent'];
    maxPoint = json['maxPoint'];
    computedLevel = json['computedLevel'];
    tarazZero = json['tarazZero'];
    kind = json['kind'];
    swapRow = json['swapRow'];
    location = json['location'];
    dpercent = json['dpercent'];
    dpercentStr = json['dpercentStr'];
    dpercentNFrom10 = json['dpercentNFrom10'];
    dlevel = json['dlevel'];
    normallevel = json['normallevel'];
    dpoint = json['dpoint'];
    dpointStr = json['dpointStr'];
    dpointNFrom10 = json['dpointNFrom10'];
    dRank = json['dRank'];
    decile = json['decile'];
    decileStr = json['decileStr'];
    dQuestionCnt = json['dQuestionCnt'];
    dCorrect = json['dCorrect'];
    dWrong = json['dWrong'];
    dWhite = json['dWhite'];
    n10 = json['n10'];
    n10Number = json['n10Number'];
    n10Same = json['n10Same'];
    abcdindex = json['abcdindex'];
    minLevel = json['minLevel'];
    minLevelPositivePercent = json['minLevelPositivePercent'];
    maxLevel = json['maxLevel'];
    lastRank = json['lastRank'];
    dEasyCorrect = json['dEasyCorrect'];
    dEasyWrong = json['dEasyWrong'];
    dEasyWhite = json['dEasyWhite'];
    // dEasyQuestions = json['dEasyQuestions'];
    dEasyQuestions = json['dEasyNoneTrueQuestions'];
    dEasyCount = json['dEasyCount'];
    dEasyNoneTrueCount = json['dEasyNoneTrueCount'];
    dEasyStr = json['dEasyStr'];
    workbookGridLocation = json['workbookGridLocation'];
  }

  num? groupCode;
  num? counter;
  num? rowId;
  num? groupId;
  String? groupName;
  num? courseId;
  String? courseName;
  bool? isPack;
  bool? show;
  bool? isSpecial;
  num? style;
  num? startPos;
  num? required;
  num? cofficient;
  String? cofficients;
  num? sigma;
  num? avgPercent;
  num? stdCount;
  num? avgPoint;
  num? maxPercent;
  num? maxPoint;
  num? computedLevel;
  num? tarazZero;
  num? kind;
  num? swapRow;
  num? location;
  num? dpercent;
  String? dpercentStr;
  num? dpercentNFrom10;
  num? dlevel;
  num? normallevel;
  num? dpoint;
  String? dpointStr;
  num? dpointNFrom10;
  num? dRank;
  num? decile;
  String? decileStr;
  num? dQuestionCnt;
  num? dCorrect;
  num? dWrong;
  num? dWhite;
  String? n10;
  num? n10Number;
  num? n10Same;
  num? abcdindex;
  num? minLevel;
  num? minLevelPositivePercent;
  num? maxLevel;
  num? lastRank;
  num? dEasyCorrect;
  num? dEasyWrong;
  num? dEasyWhite;
  String? dEasyQuestions;
  num? dEasyCount;
  num? dEasyNoneTrueCount;
  String? dEasyStr;
  num? workbookGridLocation;

  WorkBookCourseDetailList copyWith({
    num? groupCode,
    num? counter,
    num? rowId,
    num? groupId,
    String? groupName,
    num? courseId,
    String? courseName,
    bool? isPack,
    bool? show,
    bool? isSpecial,
    num? style,
    num? startPos,
    num? required,
    num? cofficient,
    String? cofficients,
    num? sigma,
    num? avgPercent,
    num? stdCount,
    num? avgPoint,
    num? maxPercent,
    num? maxPoint,
    num? computedLevel,
    num? tarazZero,
    num? kind,
    num? swapRow,
    num? location,
    num? dpercent,
    String? dpercentStr,
    num? dpercentNFrom10,
    num? dlevel,
    num? normallevel,
    num? dpoint,
    String? dpointStr,
    num? dpointNFrom10,
    num? dRank,
    num? decile,
    String? decileStr,
    num? dQuestionCnt,
    num? dCorrect,
    num? dWrong,
    num? dWhite,
    String? n10,
    num? n10Number,
    num? n10Same,
    num? abcdindex,
    num? minLevel,
    num? minLevelPositivePercent,
    num? maxLevel,
    num? lastRank,
    num? dEasyCorrect,
    num? dEasyWrong,
    num? dEasyWhite,
    String? dEasyQuestions,
    num? dEasyCount,
    num? dEasyNoneTrueCount,
    String? dEasyStr,
    num? workbookGridLocation,
  }) =>
      WorkBookCourseDetailList(
        groupCode: groupCode ?? this.groupCode,
        counter: counter ?? this.counter,
        rowId: rowId ?? this.rowId,
        groupId: groupId ?? this.groupId,
        groupName: groupName ?? this.groupName,
        courseId: courseId ?? this.courseId,
        courseName: courseName ?? this.courseName,
        isPack: isPack ?? this.isPack,
        show: show ?? this.show,
        isSpecial: isSpecial ?? this.isSpecial,
        style: style ?? this.style,
        startPos: startPos ?? this.startPos,
        required: required ?? this.required,
        cofficient: cofficient ?? this.cofficient,
        cofficients: cofficients ?? this.cofficients,
        sigma: sigma ?? this.sigma,
        avgPercent: avgPercent ?? this.avgPercent,
        stdCount: stdCount ?? this.stdCount,
        avgPoint: avgPoint ?? this.avgPoint,
        maxPercent: maxPercent ?? this.maxPercent,
        maxPoint: maxPoint ?? this.maxPoint,
        computedLevel: computedLevel ?? this.computedLevel,
        tarazZero: tarazZero ?? this.tarazZero,
        kind: kind ?? this.kind,
        swapRow: swapRow ?? this.swapRow,
        location: location ?? this.location,
        dpercent: dpercent ?? this.dpercent,
        dpercentStr: dpercentStr ?? this.dpercentStr,
        dpercentNFrom10: dpercentNFrom10 ?? this.dpercentNFrom10,
        dlevel: dlevel ?? this.dlevel,
        normallevel: normallevel ?? this.normallevel,
        dpoint: dpoint ?? this.dpoint,
        dpointStr: dpointStr ?? this.dpointStr,
        dpointNFrom10: dpointNFrom10 ?? this.dpointNFrom10,
        dRank: dRank ?? this.dRank,
        decile: decile ?? this.decile,
        decileStr: decileStr ?? this.decileStr,
        dQuestionCnt: dQuestionCnt ?? this.dQuestionCnt,
        dCorrect: dCorrect ?? this.dCorrect,
        dWrong: dWrong ?? this.dWrong,
        dWhite: dWhite ?? this.dWhite,
        n10: n10 ?? this.n10,
        n10Number: n10Number ?? this.n10Number,
        n10Same: n10Same ?? this.n10Same,
        abcdindex: abcdindex ?? this.abcdindex,
        minLevel: minLevel ?? this.minLevel,
        minLevelPositivePercent:
            minLevelPositivePercent ?? this.minLevelPositivePercent,
        maxLevel: maxLevel ?? this.maxLevel,
        lastRank: lastRank ?? this.lastRank,
        dEasyCorrect: dEasyCorrect ?? this.dEasyCorrect,
        dEasyWrong: dEasyWrong ?? this.dEasyWrong,
        dEasyWhite: dEasyWhite ?? this.dEasyWhite,
        dEasyQuestions: dEasyQuestions ?? this.dEasyQuestions,
        dEasyCount: dEasyCount ?? this.dEasyCount,
        dEasyNoneTrueCount: dEasyNoneTrueCount ?? this.dEasyNoneTrueCount,
        dEasyStr: dEasyStr ?? this.dEasyStr,
        workbookGridLocation: workbookGridLocation ?? this.workbookGridLocation,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['groupCode'] = groupCode;
    map['counter'] = counter;
    map['rowId'] = rowId;
    map['groupId'] = groupId;
    map['groupName'] = groupName;
    map['courseId'] = courseId;
    map['courseName'] = courseName;
    map['isPack'] = isPack;
    map['show'] = show;
    map['isSpecial'] = isSpecial;
    map['style'] = style;
    map['startPos'] = startPos;
    map['required'] = required;
    map['cofficient'] = cofficient;
    map['cofficients'] = cofficients;
    map['sigma'] = sigma;
    map['avgPercent'] = avgPercent;
    map['stdCount'] = stdCount;
    map['avgPoint'] = avgPoint;
    map['maxPercent'] = maxPercent;
    map['maxPoint'] = maxPoint;
    map['computedLevel'] = computedLevel;
    map['tarazZero'] = tarazZero;
    map['kind'] = kind;
    map['swapRow'] = swapRow;
    map['location'] = location;
    map['dpercent'] = dpercent;
    map['dpercentStr'] = dpercentStr;
    map['dpercentNFrom10'] = dpercentNFrom10;
    map['dlevel'] = dlevel;
    map['normallevel'] = normallevel;
    map['dpoint'] = dpoint;
    map['dpointStr'] = dpointStr;
    map['dpointNFrom10'] = dpointNFrom10;
    map['dRank'] = dRank;
    map['decile'] = decile;
    map['decileStr'] = decileStr;
    map['dQuestionCnt'] = dQuestionCnt;
    map['dCorrect'] = dCorrect;
    map['dWrong'] = dWrong;
    map['dWhite'] = dWhite;
    map['n10'] = n10;
    map['n10Number'] = n10Number;
    map['n10Same'] = n10Same;
    map['abcdindex'] = abcdindex;
    map['minLevel'] = minLevel;
    map['minLevelPositivePercent'] = minLevelPositivePercent;
    map['maxLevel'] = maxLevel;
    map['lastRank'] = lastRank;
    map['dEasyCorrect'] = dEasyCorrect;
    map['dEasyWrong'] = dEasyWrong;
    map['dEasyWhite'] = dEasyWhite;
    map['dEasyQuestions'] = dEasyQuestions;
    map['dEasyCount'] = dEasyCount;
    map['dEasyNoneTrueCount'] = dEasyNoneTrueCount;
    map['dEasyStr'] = dEasyStr;
    map['workbookGridLocation'] = workbookGridLocation;
    return map;
  }
}

OverviewWorkBook overviewWorkBookFromJson(String str) =>
    OverviewWorkBook.fromJson(json.decode(str));

String overviewWorkBookToJson(OverviewWorkBook data) =>
    json.encode(data.toJson());

class OverviewWorkBook {
  OverviewWorkBook({
    this.rows,
    this.headers,
    this.columnLocation,
    this.columnCount,
  });

  OverviewWorkBook.fromJson(dynamic json) {
    if (json['rows'] != null) {
      rows = [];
      json['rows'].forEach((v) {
        rows?.add(Rows.fromJson(v));
      });
    }
    if (json['headers'] != null) {
      headers = [];
      json['headers'].forEach((v) {
        headers?.add(Headers.fromJson(v));
      });
    }
    columnLocation = json['columnLocation'] != null
        ? json['columnLocation'].cast<num>()
        : [];
    columnCount = json['columnCount'];
  }

  List<Rows>? rows;
  List<Headers>? headers;
  List<num>? columnLocation;
  num? columnCount;

  OverviewWorkBook copyWith({
    List<Rows>? rows,
    List<Headers>? headers,
    List<num>? columnLocation,
    num? columnCount,
  }) =>
      OverviewWorkBook(
        rows: rows ?? this.rows,
        headers: headers ?? this.headers,
        columnLocation: columnLocation ?? this.columnLocation,
        columnCount: columnCount ?? this.columnCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (rows != null) {
      map['rows'] = rows?.map((v) => v.toJson()).toList();
    }
    if (headers != null) {
      map['headers'] = headers?.map((v) => v.toJson()).toList();
    }
    map['columnLocation'] = columnLocation;
    map['columnCount'] = columnCount;
    return map;
  }
}

Headers headersFromJson(String str) => Headers.fromJson(json.decode(str));

String headersToJson(Headers data) => json.encode(data.toJson());

class Headers {
  Headers({
    this.headerName,
    this.headerType,
  });

  Headers.fromJson(dynamic json) {
    headerName = json['headerName'];
    headerType = json['headerType'];
  }

  String? headerName;
  num? headerType;

  Headers copyWith({
    String? headerName,
    num? headerType,
  }) =>
      Headers(
        headerName: headerName ?? this.headerName,
        headerType: headerType ?? this.headerType,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['headerName'] = headerName;
    map['headerType'] = headerType;
    return map;
  }
}

Rows rowsFromJson(String str) => Rows.fromJson(json.decode(str));

String rowsToJson(Rows data) => json.encode(data.toJson());

class Rows {
  Rows({
    this.data,
  });

  Rows.fromJson(dynamic json) {
    data = json['data'] != null ? json['data'].cast<String>() : [];
  }

  List<String>? data;

  Rows copyWith({
    List<String>? data,
  }) =>
      Rows(
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    return map;
  }
}
