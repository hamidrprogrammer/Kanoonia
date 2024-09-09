import 'package:get/get.dart';
import 'package:kanooniha/data/serializer/workBook/nextExam/DateValueNextSerializer.dart';

import '../../../common/imports/WidgetImports.dart';
import '../main/CircularPeogress.dart';

class ExamProgressContainerUI extends StatelessWidget {
  const ExamProgressContainerUI({Key? key, required this.testInfo})
      : super(key: key);
  final DateValueNextSerializer testInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 140,
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('زمان برگزاری'),
                const MySpacer(),
                Text(
                  testInfo.dateValuePersian ?? '',
                  style: TextStyle(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                const MySpacer(),
                Text(
                  testInfo.remainingDaysText ?? '',
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          SizedBox(
              width: 150,
              height: 150,
              child: CircularProgress(
                value: (testInfo.remainingDays?.toDouble() ?? 1) / 7,
              ))
        ],
      ),
    );
  }

  String getRemainingTime(int hour) {
    if (hour < 24) return '$hour ساعت مانده به آزمون';
    return '${(hour ~/ 24).toString()} روز مانده به آزمون';
  }
}
