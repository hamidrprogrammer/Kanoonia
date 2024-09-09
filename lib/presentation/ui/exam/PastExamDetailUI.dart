import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/common/ui/WidgetSize.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';

import '../../../data/serializer/exam/TestDetailResponse.dart';
import '../../uiModel/exam/ExamDetailUIModel.dart';
import '../../viewModels/exam/ExamDetailViewModel.dart';
import '../dottedStepWidget.dart';
import '../main/Spacer.dart';

class PastExamDetailUI extends StatelessWidget {
  const PastExamDetailUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جزییات آزمون'),
      ),
      body: CubitProvider(
        create: (context) => ExamDetailViewModel(AppState.idle),
        builder: (bloc, state) {
          TestInfo testInfo = TestInfo();
          var examDetailMenuObject = bloc.getExamDetailObject();
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const MySpacer(),
                FutureBuilder(
                  future: bloc.getUserModel(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data is bool) {
                      var showChart = snapshot.data as bool;
                      return Column(
                        children: [
                          Opacity(
                              opacity: showChart == true ? 1 : .1,
                              child: TestDetailHeaderUI(testInfo: testInfo)),
                          if (showChart != true)
                            const Text(
                              'این قابلیت در نسخه بعدی فعال می شود.',
                              textAlign: TextAlign.center,
                            ),
                        ],
                      );
                    }
                    return const SizedBox(height: 300);
                  },
                ),
                const Divider(),
                ListView.builder(
                  padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      examDetailMenuObject.getExamDetailMenuObjects.length,
                  itemBuilder: (context, index) => ExamDetailMenuItemUI(
                    model: examDetailMenuObject.getExamDetailMenuObjects
                        .elementAt(index),
                    onClick: examDetailMenuObject.getExamDetailMenuObjects
                        .elementAt(index)
                        .onClick,
                  ),
                )
              ],
            ),
          );
          // return ConditionalUI<TestDetailResponse>(
          //   skeleton: const ExamDetailShimmer(),
          //   state: bloc.state,
          //   onSuccess: (data) {
          //     var testInfo = data.data?.testInfo;
          //     var examDetailMenuObject =
          //         ExamDetailMenuObject(testInfo?.testDate?.toInt() ?? 0);
          //     return SingleChildScrollView(
          //       physics: const BouncingScrollPhysics(),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //           const MySpacer(),
          //           FutureBuilder(
          //             future: bloc.getUserModel(),
          //             builder: (context, snapshot) {
          //               if (snapshot.hasData && snapshot.data is bool) {
          //                 var showChart = snapshot.data as bool;
          //                 return Column(
          //                   children: [
          //                     Opacity(
          //                         opacity: showChart == true ? 1 : .1,
          //                         child:
          //                             TestDetailHeaderUI(testInfo: testInfo)),
          //                     if (showChart != true)
          //                       const Text(
          //                         'این قابلیت در نسخه بعدی فعال می شود.',
          //                         textAlign: TextAlign.center,
          //                       ),
          //                   ],
          //                 );
          //               }
          //               return const SizedBox(height: 300);
          //             },
          //           ),
          //           const Divider(),
          //           ListView.builder(
          //             padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
          //             physics: const NeverScrollableScrollPhysics(),
          //             shrinkWrap: true,
          //             itemCount:
          //                 examDetailMenuObject.getExamDetailMenuObjects.length,
          //             itemBuilder: (context, index) => ExamDetailMenuItemUI(
          //               model: examDetailMenuObject.getExamDetailMenuObjects
          //                   .elementAt(index),
          //               onClick: examDetailMenuObject.getExamDetailMenuObjects
          //                   .elementAt(index)
          //                   .onClick,
          //             ),
          //           )
          //         ],
          //       ),
          //     );
          //   },
          // );
        },
      ),
    );
  }

  String getRemainingTime(int hour) {
    if (hour < 24) return '$hour ساعت مانده به آزمون';
    return '${(hour ~/ 24).toString()} روز مانده به آزمون';
  }
}

class ExamDetailMenuItemUI extends StatelessWidget {
  const ExamDetailMenuItemUI({
    super.key,
    required this.model,
    required this.onClick,
  });

  final ExamDetailUIModel model;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WidgetSize.baseRadiusSize),
      ),
      elevation: 5,
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(WidgetSize.baseRadiusSize),
        child: Padding(
          padding: const EdgeInsets.all(WidgetSize.basePaddingSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: context.theme.primaryColor.withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  model.iconData,
                  color: context.theme.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(model.title),
                  const MySpacer(),
                  Text(
                    model.description,
                    style: context.textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TestDetailHeaderUI extends StatelessWidget {
  const TestDetailHeaderUI({
    super.key,
    required this.testInfo,
  });

  final TestInfo? testInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DottedStepsWidget(
          widgets: [
            MultiLineText(
                firstLine: 'تعداد داوطلبان',
                secondLine: testInfo?.totalStudents?.toString() ?? ''),
            MultiLineText(
                firstLine: 'میانگین تراز',
                secondLine: testInfo?.avgTotalLevel?.toString() ?? ''),
            MultiLineText(
                firstLine: 'بهترین تراز',
                secondLine: testInfo?.maxTotalLevel?.toString() ?? '')
          ],
        ),
        Container(
          padding: const EdgeInsets.all(WidgetSize.pagePaddingSize * 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: context.theme.primaryColor, width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('زمان برگزاری'),
              const MySpacer(),
              Text(
                testInfo?.testDateInPersian ?? '',
                style: TextStyle(
                    color: context.theme.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const MySpacer(),
            ],
          ),
        )
      ],
    );
  }
}

class MultiLineText extends StatelessWidget {
  const MultiLineText({
    super.key,
    required this.firstLine,
    required this.secondLine,
  });

  final String firstLine, secondLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$firstLine'
      '\n'
      '$secondLine',
      style: const TextStyle(fontSize: 12),
    );
  }
}
