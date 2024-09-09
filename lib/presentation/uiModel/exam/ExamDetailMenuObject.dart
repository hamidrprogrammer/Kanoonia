import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kanooniha/presentation/ui/workbook/GetWorkBookCommentBottomSheetUI.dart';

import '../../ui/workbook/GetTestToolBoxBottomSheetUI.dart';
import '../../ui/workbook/WorkBookBottomSheetUI.dart';
import 'ExamDetailUIModel.dart';

class ExamDetailMenuObject {
  final int testDate;
  late List<ExamDetailUIModel> _models;

  ExamDetailMenuObject(this.testDate) {
    _models = [
      ExamDetailUIModel(
        title: 'دریافت کارنامه',
        description: 'کارنامه اصلی',
        iconData: CupertinoIcons.square_list_fill,
        onClick: () {
          Get.bottomSheet(WorkBookBottomSheetUI(
            testDate: testDate,
          ));
        },
      ),
      ExamDetailUIModel(
        title: 'نظرات پشتیبان',
        description: 'نمایش نظرات پشتیبان',
        iconData: CupertinoIcons.headphones,
        onClick: () {
          Get.bottomSheet(GetWorkBookCommentBottomSheetUI(
            testDateExtra: testDate,
          ));
        },
      ),
      // ExamDetailUIModel(
      //     title: 'ثبت اشکالات آزمون',
      //     description: 'اشکالات آزمون آنلاین',
      //     iconData: CupertinoIcons.plus_rectangle_fill_on_rectangle_fill,
      //     onClick: () {}),
      ExamDetailUIModel(
        title: 'اشانتیون',
        description: 'مجله آزمون/سخنرانی و ...',
        iconData: CupertinoIcons.gift_alt_fill,
        onClick: () {
          Get.bottomSheet(GetTestToolBoxBottomSheetUI(
            testDate: testDate,
          ));
        },
      ),
      // ExamDetailUIModel(
      //     title: 'پاسخ به اشکالات آزمون',
      //     description: 'بررسی اشکالات ثبت شده',
      //     iconData: CupertinoIcons.rectangle_on_rectangle_angled,
      //     onClick: () {}),
    ];
  }

  List<ExamDetailUIModel> get getExamDetailMenuObjects => _models;

  int get getTestDate => testDate;
}
