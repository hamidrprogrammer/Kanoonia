import 'package:get/get.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/data/serializer/article/ArticleItemSerializer.dart';
import 'package:kanooniha/data/serializer/newMessages/messageItem.dart';
import 'package:kanooniha/data/serializer/user/UserInfoSerializer.dart';
import 'package:kanooniha/data/serializer/workBook/newLastExam/DateValueLastSerializer.dart';
import 'package:kanooniha/data/serializer/workBook/nextExam/DateValueNextSerializer.dart';
import 'package:kanooniha/presentation/ui/dottedStepWidget.dart';
import 'package:kanooniha/presentation/ui/exam/ChartIndicator.dart';
import 'package:kanooniha/presentation/ui/inbox/InboxPageUI.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:kanooniha/presentation/uiModel/home/MessagesNavigationModel.dart';
import 'package:kanooniha/presentation/uiModel/profile/UserModel.dart';
import 'package:kanooniha/presentation/viewModels/home/HomeViewModel.dart';
import 'package:multi_charts/multi_charts.dart';

import '../../../data/serializer/exam/PastTestResponse.dart';
import '../../../data/serializer/exam/TargetItem.dart';
import '../../uiModel/messenger/MessengerUIModel.dart';
import '../../viewModels/exam/ExamsViewModel.dart';
import '../main/EmptyPageUI.dart';
import '../messenger/MessengerItemUI.dart';
import 'ExamPageShimmer.dart';
import 'ExamProgressContainerUI.dart';
import 'ExamShimmer.dart';

class ExamPageUI extends StatefulWidget {
  ///  I added this code on [radar_chart_painter.dart]
  ///   RadarChartDrawUtils.drawLabels(
  ///   canvas,
  ///   center,
  ///   values.map((e) => e.toStringAsFixed(0)).toList(),
  ///   valuePoints,
  ///   CommonPaintUtils.getTextSize(size/1.2, textScaleFactor),
  ///   labelWidth ??
  ///   CommonPaintUtils.getDefaultLabelWidth(size, center, angle),
  ///   maxLinesForLabels ?? CommonPaintUtils.getDefaultMaxLinesForLabels(size),
  ///   labelColor
  ///   );

  const ExamPageUI({Key? key}) : super(key: key);

  @override
  State<ExamPageUI> createState() => _ExamPageUIState();
}

class _ExamPageUIState extends State<ExamPageUI> {
  final ExamsViewModel _viewModel = ExamsViewModel(AppState.idle);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => _viewModel,
      builder: (bloc, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                ConditionalUI<DateValueLastSerializer>(
                  onReloadClick: bloc.onReloadClick,
                  showError: false,
                  skeleton: const ExamPageShimmer(),
                  state: bloc.workBookData,
                  onSuccess: (data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8.0),
                          child: Text(
                            data.title ?? '',
                            style: context.textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: DottedStepsWidget(
                                  widgets: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('رتبه ',
                                            style: context.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        Text(
                                          (' : ').toString(),
                                          style: context.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          (data.totalRank ?? '').toString(),
                                          style: context.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('تراز ',
                                            style: context.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        Text(
                                          (' : ').toString(),
                                          style: context.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          (data.totalLevel ?? '').toString(),
                                          style: context.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ExamProgressContainerUI(
                                  testInfo: data.toNextValue()),
                            )
                          ],
                        ),
                        const MySpacer(size: 16),
                        const Divider(),
                      ],
                    );
                  },
                ),
                ConditionalUI<DateValueNextSerializer>(
                  onReloadClick: bloc.onReloadClick,
                  showError: false,
                  skeleton: const ExamShimmer(),
                  state: bloc.currentExamState,
                  onSuccess: (data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8.0),
                          child: Text(
                            data.title ?? '',
                            style: context.textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        NextExamDetail(testInfo: data),
                        const MySpacer(),
                      ],
                    );
                  },
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'پیام ها',
                        style: context.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          context
                              .read<HomeViewModel>()
                              .onIndexChange()
                              .call(MessagesNavigationModel());
                        },
                        label: const Text('مشاهده همه'),
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                MessengerInExamPageUi(
                  state: bloc.messagesState,
                  onClick: (msgModel) {
                    bloc.navigate(msgModel);
                  },
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'اخبار',
                        style: context.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox.shrink(),
                    ],
                  ),
                ),
                ConditionalUI<List<ArticleItemSerializer>>(
                  onReloadClick: bloc.onReloadClick,
                  skeleton: const SizedBox.shrink(),
                  state: bloc.newsState,
                  onSuccess: (data) {
                    if (data.isEmpty == true) {
                      return const EmptyPageUI();
                    } else {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding:
                            const EdgeInsets.all(WidgetSize.pagePaddingSize),
                        itemBuilder: (context, index) {
                          var item = data.elementAt(index);
                          return InboxMessageItemUI(item: item);
                        },
                        separatorBuilder: (context, index) => const MySpacer(),
                        itemCount: data.length,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class MessengerInExamPageUi extends StatelessWidget {
  const MessengerInExamPageUi({
    Key? key,
    required this.state,
    required this.onClick,
  }) : super(key: key);
  final AppState state;
  final Function(MessengerUIModel) onClick;

  @override
  Widget build(BuildContext context) {
    return ConditionalUI<List<NewMessageItem>>(
      onReloadClick: () {

      },
      skeleton: const SizedBox.shrink(),
      state: state,
      onSuccess: (data) {
        if (data.isEmpty) return const EmptyPageUI();
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
          itemBuilder: (context, index) => MessengerItemUI(
            model: data.elementAt(index).getMessengerUiModel(),
            onClick: () {
              onClick.call(data.elementAt(index).getMessengerUiModel());
            },
          ),
          separatorBuilder: (context, index) => const MySpacer(size: 16),
          itemCount: data.length > 5 ? 5 : data.length,
        );
      },
    );
  }
}

class ExamRadarChartUI extends StatelessWidget {
  const ExamRadarChartUI({
    super.key,
    required this.tarazDataModel,
  });

  final TarazDataModel tarazDataModel;

  @override
  Widget build(BuildContext context) {
    return RadarChart(
      strokeColor: Colors.blue,
      values: [
        tarazDataModel.userTaraz,
        tarazDataModel.avgTaraz,
        tarazDataModel.maxSpecialTaraz,
        // tarazDataModel.maxPublicTaraz,
        tarazDataModel.minTaraz,
      ],
      labels: const [
        'تراز من',
        'میانگین تراز',
        'بهترین تراز',
        // 'بهترین تراز عمومی',
        'کمترین تراز'
      ],
      maxValue: 16000,
      fillColor: Colors.blue,
      chartRadiusFactor: 0.7,
    );
  }
}

class NextExamDetail extends StatelessWidget {
  const NextExamDetail({
    super.key,
    required this.testInfo,
  });

  final DateValueNextSerializer testInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: DottedStepsWidget(
                widgets: [
                  Text(testInfo.dateValuePersian ?? ''),
                  // Text('تعداد داوطلبان\n${testInfo. ?? ''} نفر'),
                ],
              ),
            ),
          ),
          Expanded(flex: 1, child: ExamProgressContainerUI(testInfo: testInfo))
        ],
      ),
    );
  }
}

class CoursesWrapWidget extends StatelessWidget {
  const CoursesWrapWidget({
    super.key,
    required this.targetLevels,
  });

  final List<TargetItem?>? targetLevels;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: WidgetSize.pagePaddingSize),
        child: Wrap(
            children: targetLevels?.map((e) {
                  if (e?.courseName?.isNotEmpty == true) {
                    return ChartIndicator(targetItem: e);
                  }
                  return const SizedBox.shrink();
                }).toList() ??
                []));
  }
}
