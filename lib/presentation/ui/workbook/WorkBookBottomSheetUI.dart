import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/common/ui/WidgetSize.dart';
import 'package:kanooniha/data/serializer/workBook/kinds/workBookKindItem.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';

import '../../viewModels/workBook/GetWorkBookKindsViewModel.dart';
import '../main/Spacer.dart';
import 'GetWorkBookKindsShimmerUI.dart';

class WorkBookBottomSheetUI extends StatelessWidget {
  const WorkBookBottomSheetUI({Key? key, required this.testDate})
      : super(key: key);
  final int testDate;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => GetWorkBookKindsViewModel(AppState.idle),
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
              return ConditionalUI<List<WorkBookKindItem>>(
                onReloadClick: bloc.onReloadClick,
                skeleton: const GetWorkBookKindsShimmerUI(),
                state: bloc.workBookState,
                onSuccess: (data) {
                  return Padding(
                    padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'نحوه دریافت کارنامه را انتخاب کنید',
                          style: context.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const MySpacer(),
                        ListView.separated(
                          separatorBuilder: (context, index) =>
                              const MySpacer(),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var item = data.elementAt(index);
                            return ListTile(
                              horizontalTitleGap: 0,
                              title: Text(item.title),
                              trailing: bloc.getState(item.kind).isLoading
                                  ? MyLoader(
                                      color: context.theme.primaryColor,
                                    )
                                  : const Icon(CupertinoIcons.cloud_download),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: Colors.grey.shade200, width: 1.5),
                              ),
                              enabled: true,
                              onTap: () => bloc.onDownloadClick(
                                  kindId: item.kind, testDate: testDate),
                              leading:
                                  const Icon(CupertinoIcons.square_list_fill),
                              iconColor: Colors.blue.shade200,
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            });
      },
    );
  }
}
