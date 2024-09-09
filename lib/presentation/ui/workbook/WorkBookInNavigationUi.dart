import 'package:flutter/material.dart';
import 'package:kanooniha/data/serializer/workBook/WorkBookInNavigationResponse.dart';
import 'package:kanooniha/data/serializer/workBook/extension/WorkBookExtension.dart';
import 'package:kanooniha/presentation/states/app_state.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/custom_leasing.dart';
import 'package:kanooniha/presentation/ui/workbook/WorkBookInNavigationShimmer.dart';
import 'package:kanooniha/presentation/viewModels/workBook/WorkBookInNavigationViewModel.dart';

class WorkBookInNavigationUi extends StatelessWidget {
  const WorkBookInNavigationUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('کارنامه زودهنگام'),
        leading: const CustomLeading(),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CubitProvider(
          create: (context) => WorkBookInNavigationViewModel(AppState.idle),
          builder: (bloc, state) {
            return ConditionalUI<WorkBookInNavigationResponse>(
              onReloadClick: bloc.onReloadClick,
              skeleton: const WorkBookInNavigationShimmer(),
              state: state,
              onSuccess: (data) {
                data.workBookCourseDetailList?.filterUnusedData();
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FutureBuilder(
                          future: bloc.getCroupCode(data),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data is String &&
                                data.overviewWorkBook != null) {
                              return WorkBookTopBar(
                                data: data.overviewWorkBook!,
                                testDate: data.date ?? '',
                                groupCode: snapshot.data?.toString() ?? '',
                              );
                            }
                            return Container(
                              margin: const EdgeInsets.all(16.0),
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16.0)),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                            fit: BoxFit.fitWidth, child: MyTable(data: data)),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class WorkBookTopBar extends StatelessWidget {
  const WorkBookTopBar(
      {super.key,
      required this.data,
      required this.testDate,
      required this.groupCode});

  final OverviewWorkBook data;
  final String testDate;
  final String groupCode;

  @override
  Widget build(BuildContext context) {
    var model = data.getWorkBookModel(groupCode);
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        TitleWithDataWidget(
          name: 'تاریخ آزمون',
          data: testDate,
        ),
        data.tarazCondition
            ? TitleWithDataWidget(
                name: 'تراز',
                data: model.taraz,
              )
            : const SizedBox.shrink(),
        data.levelCondition
            ? TitleWithDataWidget(
                name: 'رتبه کشوری',
                data: model.level,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

class MyTable extends StatelessWidget {
  const MyTable({
    super.key,
    required this.data,
  });

  final WorkBookInNavigationResponse data;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 3,
      minScale: .1,
      child: DataTable(
          border: TableBorder.all(
              borderRadius: BorderRadius.circular(4.0), color: Colors.grey),
          columns: [
            myColumnWidget('نام درس'),
            myColumnWidget('درصد'),
            myColumnWidget('چند از 10'),
            myColumnWidget('وضعیت درس'),
            myColumnWidget('سوالات ساده اشتباه زده یا نزده'),
          ],
          rows: (data.workBookCourseDetailList ?? [])
              .map((e) => DataRow(cells: [
                    myCellWidget(e.courseName ?? ''),
                    myCellWidget(e.userScoreFromPercent),
                    myCellWidget(e.userScoreFromN10),
                    myCellWidget(e.getCourseStateFromN10),
                    myCellWidget(e.dEasyQuestions ?? ''),
                  ]))
              .toList()),
    );
  }
}

DataCell myCellWidget(String data) => DataCell(Center(
        child: Text(
      data,
      textAlign: TextAlign.center,
      textScaleFactor: 1,
    )));

DataColumn myColumnWidget(String name) => DataColumn(
        label: Expanded(
      child: Center(
        child: Text(name,
            textAlign: TextAlign.center,
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 1),
      ),
    ));

class TitleWithDataWidget extends StatelessWidget {
  final String name, data;

  const TitleWithDataWidget({
    super.key,
    required this.name,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(': $data')
        ],
      ),
    );
  }
}
