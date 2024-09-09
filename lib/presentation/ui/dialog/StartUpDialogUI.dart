import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/uiModel/profile/UserModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../../data/serializer/poll/CheckForPollResponse.dart';
import '../../../domain/useCase/home/StartupTaskUseCase.dart';
import '../../viewModels/poll/StartupDialogViewModel.dart';

class StartupDialogUI extends StatelessWidget {
  const StartupDialogUI({Key? key, this.response, this.count})
      : super(key: key);
  final CheckForPollResponse? response;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => StartupDialogViewModel(AppState.idle),
      builder: (bloc, state) {
        bloc.count ??= count;
        bloc.response ??= response;
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            insetPadding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                      child: FutureBuilder(
                        future: bloc.getUserModel(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data is UserModel) {
                            var userModel = snapshot.data as UserModel;
                            return Text(
                              '${userModel.fullName} عزیز',
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
                const MySpacer(size: 20),
                if (count != null)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(CupertinoIcons.cube_box_fill, size: 20),
                    ),
                    title: Text('شما ${bloc.count} پیام خوانده نشده دارید',
                        style: context.textTheme.bodySmall),
                    trailing: Icon(
                      CupertinoIcons.right_chevron,
                      color: context.theme.primaryColor,
                    ),
                    onTap: bloc.messenger,
                  ),
                if (count != null && response != null) const Divider(),
                if (response != null)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child:
                          const Icon(CupertinoIcons.list_number_rtl, size: 20),
                    ),
                    title: Text(
                      'برای شرکت در نظرسنجی کلیک کنید',
                      style: context.textTheme.bodySmall,
                    ),
                    onTap: () async {
                      bloc.pop();
                      if (response?.data?.pollUrl?.url != null) {
                        await _launchUrl(response!.data!.pollUrl!.url!);
                        if (kIsWeb) {
                          checkStarUpData();
                        }
                      }
                    },
                  ),
                const MySpacer(size: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void checkStarUpData() {
    StartupTaskUseCase.invoke();
  }

  Future<bool> _launchUrl(String link) async {
    return launchUrl(Uri.parse(link));
  }
}
