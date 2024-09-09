import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/data/serializer/workBook/kinds/workBookKindItem.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/presentation/states/app_state.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:kanooniha/presentation/ui/workbook/GetWorkBookKindsShimmerUI.dart';
import 'package:kanooniha/presentation/viewModels/workBook/GetWorkBookKindsViewModel.dart';

class NewWorkBookUi extends StatelessWidget {
  const NewWorkBookUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => GetWorkBookKindsViewModel(AppState.idle),
      builder: (bloc, state) {
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
                  ListView.separated(
                    separatorBuilder: (context, index) => const MySpacer(),
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
                            : item.isPdf
                                ? const Icon(CupertinoIcons.cloud_download)
                                : const SizedBox.shrink(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                              color: Colors.grey.shade200, width: 1.5),
                        ),
                        enabled: true,
                        onTap: () {
                          if (item.isActive == false) return;
                          if (item.isDateValue) {
                            bloc.navigateToPastDates(item.kind);
                          } else {
                            if (item.isPdf) {
                              bloc.onDownloadClick(kindId: item.kind);
                            } else {
                              bloc.navigateToRoute(item.kind);
                            }
                          }
                        },
                        leading: const Icon(CupertinoIcons.square_list_fill),
                        iconColor: Colors.blue.shade200,
                      );
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
