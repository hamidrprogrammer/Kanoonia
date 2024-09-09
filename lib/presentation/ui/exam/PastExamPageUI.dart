import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/data/body/workBook/newWorkBook/new_workBook_body.dart';
import 'package:kanooniha/data/serializer/workBook/dateValueWorkBookList/dateValueWorkBookList.dart';
import 'package:kanooniha/presentation/ui/dialog/newWorkBook/DownloadFileDialog.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/custom_leasing.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../states/app_state.dart';
import '../../viewModels/exam/ExamsViewModel.dart';
import '../main/ConditionalUI.dart';
import 'PastExamsShimmer.dart';

class PastExamPageUI extends StatelessWidget {
  const PastExamPageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('آزمون های گذشته'),
        leading: const CustomLeading(),
      ),
      body: CubitProvider(
        create: (context) => ExamsViewModel.initForPastExams(AppState.idle),
        builder: (bloc, state) {
          return ConditionalUI<List<DateValueWorkBookList>>(
            onReloadClick: bloc.onReloadClick,
            skeleton: const PastExamsShimmer(),
            state: bloc.pastExamState,
            onSuccess: (data) =>
                PastExamsUI(testDates: data, kindId: bloc.kindId),
          );
        },
      ),
    );
  }
}

class PastExamsUI extends StatelessWidget {
  const PastExamsUI({
    super.key,
    required this.testDates,
    required this.kindId,
  });

  final List<DateValueWorkBookList> testDates;
  final String kindId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(WidgetSize.basePaddingSize),
      itemCount: testDates.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return PastTestItemUI(item: testDates.elementAt(index), kindId: kindId);
      },
    );
  }
}

class PastTestItemUI extends StatelessWidget {
  const PastTestItemUI({
    super.key,
    required this.item,
    required this.kindId,
  });

  final DateValueWorkBookList item;
  final String kindId;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(WidgetSize.basePaddingSize),
      shape: RoundedRectangleBorder(
        borderRadius: 16.bRadius,
      ),
      elevation: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: 16.dpe,
            margin: 8.dpe,
            decoration: BoxDecoration(
              borderRadius: 16.bRadius,
              color: Colors.grey.shade50,
            ),
            child:
                const Icon(CupertinoIcons.square_list_fill, color: Colors.blue),
          ),
          8.dph,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('تاریخ : ', style: context.textTheme.labelMedium),
                  Text(item.dateValue.toString(),
                      style: context.textTheme.bodyMedium),
                ],
              ),
              2.dpv,
              Row(
                children: [
                  Text('رتبه : ', style: context.textTheme.labelMedium),
                  Text(item.totalRank.toString(),
                      style: context.textTheme.bodyMedium),
                  4.dph,
                  Text('تراز : ', style: context.textTheme.labelMedium),
                  Text(item.totalLevel.toString(),
                      style: context.textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          const Spacer(),
          TextButton(
              child: const Text('دریافت کارنامه'),
              onPressed: () {
                Get.dialog(DownloadFileDialog(
                  body: NewWorkBookBody(
                      kind: kindId.toString(),
                      dateValue: item.dateValue.toString()),
                ));
              }),
        ],
      ),
    );
  }
}
