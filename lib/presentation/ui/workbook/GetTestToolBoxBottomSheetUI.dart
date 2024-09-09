import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/common/ui/WidgetSize.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';

import '../../../data/serializer/toolBox/GetTestToolBoxResponse.dart';
import '../../viewModels/workBook/GetTestToolBoxViewModel.dart';
import '../main/EmptyPageUI.dart';
import '../main/Spacer.dart';
import 'GetWorkBookKindsShimmerUI.dart';

class GetTestToolBoxBottomSheetUI extends StatelessWidget {
  const GetTestToolBoxBottomSheetUI({Key? key, required this.testDate})
      : super(key: key);
  final int testDate;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => GetTestToolBoxViewModel(AppState.idle, testDate),
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
              return ConditionalUI<GetTestToolBoxResponse>(
                onReloadClick: bloc.onReloadClick,
                skeleton: const GetWorkBookKindsShimmerUI(),
                state: state,
                onSuccess: (data) {
                  return Padding(
                    padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'اشانتیون',
                          style: context.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const MySpacer(),
                        if (data.data?.testToolBox?.isEmpty == true)
                          const EmptyPageUI()
                        else
                          ListView.separated(
                            separatorBuilder: (context, index) =>
                                const MySpacer(),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.data?.testToolBox?.length ?? 0,
                            itemBuilder: (context, index) {
                              var item =
                                  data.data?.testToolBox?.elementAt(index);
                              return ListTile(
                                horizontalTitleGap: 0,
                                title: Text(item?.title ?? ''),
                                trailing:
                                    const Icon(CupertinoIcons.folder_open),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                      color: Colors.grey.shade200, width: 1.5),
                                ),
                                enabled: true,
                                onTap: () => bloc.onDownloadClick(item),
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
