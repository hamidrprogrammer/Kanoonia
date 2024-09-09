import 'package:flutter/material.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/data/serializer/exam/ExamDetailResponse.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';

import '../../viewModels/exam/ExamsViewModel.dart';
import '../main/EmptyPageUI.dart';
import 'ExamPageUI.dart';
import 'TargetPageShimmer.dart';
import 'outLabelChart/PieOutLabelChart.dart';

class TargetPageUi extends StatelessWidget {
  const TargetPageUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ExamsViewModel(AppState.idle),
      builder: (bloc, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('هدف گذاری'),
            actions: [
              TextButton.icon(
                  onPressed: bloc.navigateToAddTargetPage.call(),
                  icon: const Icon(Icons.add),
                  label: const Text('افزودن هدف'))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ConditionalUI<ExamDetailResponse>(
                  onReloadClick: bloc.onReloadClick,
                  skeleton: const TargetPageShimmer(),
                  state: bloc.currentExamState,
                  onSuccess: (data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const MySpacer(),
                        if (data.data?.targetLevels?.isEmpty == true)
                          const EmptyPageUI(msg: 'برای هدف گذاری آزمون پیش رو, روی افزودن هدف کلیک کنید'),
                        if (data.data?.targetLevels?.isNotEmpty == true)
                          CoursesWrapWidget(
                            targetLevels: data.data?.targetLevels,
                          ),
                        if (data.data?.targetLevels?.isNotEmpty == true)
                          Padding(
                            padding: const EdgeInsets.all(
                                WidgetSize.pagePaddingSize),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: PieOutsideLabelChart(
                                  items: data.data?.targetLevels ?? [],
                                ),
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
