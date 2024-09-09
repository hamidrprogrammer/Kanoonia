import 'package:get/get.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/data/serializer/exam/ExamCourceResponse.dart';
import 'package:kanooniha/data/serializer/exam/PastTestResponse.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';

import '../../../data/serializer/exam/CourseRangePickerUI.dart';
import '../../viewModels/profile/AddTargetViewModel.dart';
import '../main/BaseShimmer.dart';
import '../main/ConditionalUI.dart';
import '../main/EmptyPageUI.dart';
import 'TargetsShimmer.dart';

class AddTargetPageUI extends StatelessWidget {
  const AddTargetPageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => AddTargetViewModel(AppState.idle),
      builder: (bloc, state) {
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(155),
              child: Column(
                children: [
                  AppBar(
                    title: const Text('افزودن هدف'),
                  ),
                  ExamTimePickerFormField(
                    state: bloc.datesState,
                    onValueChange: bloc.onTimesChanged.call(),
                    selectedDate: bloc.selectedDate,
                  ),
                ],
              ),
            ),
            body: ConditionalUI<ExamCourceResponse>(
              onReloadClick: bloc.onReloadClick,
              skeleton: const TargetsShimmer(),
              state: bloc.examState,
              onSuccess: (courses) {
                if (courses.data?.courses?.isEmpty == true) {
                  return const EmptyPageUI();
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                  physics: const BouncingScrollPhysics(),
                  itemCount: courses.data?.courses?.length,
                  itemBuilder: (context, index) {
                    var item = courses.data?.courses?[index];
                    return CourseRangePickerUI(
                      onValueChange: bloc.onValueChanged
                          .call(item?.courseId?.toInt() ?? 0),
                      value: bloc
                          .getSliderValue(item?.courseId?.toInt() ?? 0)
                          .value,
                      course: item,
                      state: bloc.getState(item?.courseId?.toInt() ?? 0),
                      onClick: (percent, taraz) {
                        bloc.setTarget(
                          item?.courseId?.toInt() ?? 0,
                          percent,
                          taraz.toInt().toString(),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ExamTimePickerFormField extends StatelessWidget {
  const ExamTimePickerFormField({
    super.key,
    required this.state,
    required this.onValueChange,
    required this.selectedDate,
  });

  final AppState state;
  final Function(int?) onValueChange;
  final int selectedDate;

  @override
  Widget build(BuildContext context) {
    return ConditionalUI<PastTestResponse>(
      onReloadClick: () {

      },
      skeleton: const TimesSkeleton(),
      state: state,
      onSuccess: (testResponse) {
        return Padding(
          padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField<int>(
              value: selectedDate == 0 ? null : selectedDate,
              menuMaxHeight: 300,
              isDense: false,
              isExpanded: false,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              hint: Text(
                'تاریخ آزمون گذشته موردنظر را انتخاب کنید',
                style: context.textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onChanged: onValueChange,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.date_range),
              ),
              items: List.generate(testResponse.data?.testDates?.length ?? 0,
                  (index) {
                var item = testResponse.data?.testDates?.elementAt(index);
                return DropdownMenuItem<int>(
                  value: item?.dateValue?.toInt(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.0),
                              color: selectedDate == item?.dateValue
                                  ? Colors.blue.shade50
                                  : Colors.transparent),
                          child: Text(
                            item?.dateValue?.toString() ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class TimesSkeleton extends StatelessWidget {
  const TimesSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.all(WidgetSize.basePaddingSize),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: Colors.grey.shade200,
        ),
      ),
    );
  }
}
