import 'package:kanooniha/data/serializer/workBook/WorkBookInNavigationResponse.dart';
import 'package:kanooniha/data/serializer/workBook/model/WorkBookModel.dart';

extension WorkBookCourseExtension on WorkBookCourseDetailList {
  String get getCourseStateFromN10 {
    if (n10 == null) return "";
    if (n10 == "0") return "0";
    if (n10 == "منطبق") return "";
    if (n10!.contains("+") || n10!.contains("=")) return "قوی تر از هم تراز";
    if (n10 == "1-") return "تلنگری";
    if (n10!.contains("-")) return "نیاز به تلاش خیلی بیشتر";
    return "";
  }

  String get userScoreFromN10 {
    var otherCourses = ['41', '43', '45', '46'];
    return otherCourses.contains(groupCode?.toString())
        ? dpointNFrom10?.toString() ?? ''
        : dpercentNFrom10?.toString() ?? '';
  }

  String get userScoreFromPercent {
    var otherCourses = ['41', '43', '45', '46'];
    return otherCourses.contains(groupCode?.toString())
        ? dpointStr ?? ''
        : dpercentStr ?? '';
  }
}

extension WorkBookDetailExtensions on OverviewWorkBook {
  bool get tarazCondition {
    var index = headers?.indexWhere((element) => element.headerName == 'تراز');
    return (index != null && index != -1);
  }

  bool get levelCondition {
    var index =
        headers?.indexWhere((element) => element.headerName == 'رتبه‌ی کشوری');
    return (index != null && index != -1);
  }

  bool get checkRowsNullable {
    return rows == null ||
        rows?.isEmpty == true ||
        rows?.first.data == null ||
        rows?.first.data?.isEmpty == true;
  }

  bool checkRowsByIndex(int index) {
    return rows!.first.data!.length - 1 < index;
  }

  String getTaraz(String groupCode) {
    if (checkRowsNullable) {
      return "-";
    }
    var index = headers?.indexWhere((element) => element.headerName == 'تراز');
    if (index == null || index == -1) return '';

    if (checkRowsByIndex(index)) {
      return "-";
    }
    var courses = ['31', '33', '35', '41', '43', '45', '46', '27'];

    if (courses.contains(groupCode)) {
      return rows?.last.data?.elementAt(index) ?? '';
    } else {
      return rows?.first.data?.elementAt(index) ?? '';
    }
  }

  String getLevel(String groupCode) {
    if (checkRowsNullable) {
      return "-";
    }
    var index =
        headers?.indexWhere((element) => element.headerName == 'رتبه‌ی کشوری');
    if (index == null || index == -1) return '';

    if (checkRowsByIndex(index)) {
      return "-";
    }

    var courses = ['31', '33', '35', '41', '43', '45', '46', '27'];
    if (courses.contains(groupCode)) {
      return rows?.last.data?.elementAt(index) ?? '';
    } else {
      return rows?.last.data?.elementAt(index) ?? '';
    }
  }

  WorkBookModel getWorkBookModel(String groupCode) {
    return WorkBookModel(
        level: getLevel(groupCode), taraz: getTaraz(groupCode));
  }
}

extension WorkBookListExtension on List<WorkBookCourseDetailList>? {
  void filterUnusedData() {
    this?.removeWhere((element) =>
        element.courseName == "0" ||
        element.courseName == " " ||
        element.dpercentStr == "-100%" ||
        (element.courseName ?? '').contains("تیز"));
  }
}
