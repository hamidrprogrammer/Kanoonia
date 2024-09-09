import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/core/Logger.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';

import '../../../data/serializer/workBook/GetWorkBookCommentResponse.dart';
import '../../viewModels/workBook/GetWorkBookCommentViewModel.dart';
import '../main/ConditionalUI.dart';
import '../main/EmptyPageUI.dart';
import 'GetWorkBookCommentShimmerUI.dart';

class GetWorkBookCommentBottomSheetUI extends StatelessWidget {
  const GetWorkBookCommentBottomSheetUI({Key? key, required this.testDateExtra})
      : super(key: key);
  final int testDateExtra;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) =>
          GetWorkBookCommentViewModel(AppState.idle, testDateExtra),
      builder: (bloc, state) {
        return BottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          onClosing: () {},
          builder: (context) {
            return ConditionalUI<GetWorkBookCommentResponse>(
              onReloadClick: bloc.onReloadClick,
              skeleton: const GetWorkBookCommentShimmerUI(),
              state: state,
              onSuccess: (data) {
                Logger.d(data.data?.state?.toString() ?? 'null');
                return Padding(
                  padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'نظرات پشتیبان',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const MySpacer(size: 20),
                      if (data.data?.state == 1)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: context.theme.primaryColor.withAlpha(50),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                CupertinoIcons.headphones,
                                color: context.theme.primaryColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Bubble(
                                nipOffset: 17,
                                padding: const BubbleEdges.all(
                                    WidgetSize.pagePaddingSize),
                                color: Colors.blue.shade50,
                                nip: BubbleNip.rightTop,
                                child: Text(
                                    data.data?.comment?.workBookComment ?? ''),
                              ),
                            ),
                          ],
                        )
                      else
                        const EmptyPageUI()
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
