import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/uiModel/profile/UserModel.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../viewModels/messenger/StartupMessagesDialogViewModel.dart';

class UnreadMessagesDialogUI extends StatelessWidget {
  const UnreadMessagesDialogUI({Key? key, required this.count})
      : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => StartupMessagesDialogViewModel(AppState.idle),
      builder: (bloc, state) {
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
                        future: null,
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
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(CupertinoIcons.cube_box_fill, size: 20),
                  ),
                  title: Text('شما $count پیام خوانده نشده دارید',
                      style: context.textTheme.bodySmall),
                  trailing: Icon(
                    CupertinoIcons.right_chevron,
                    color: context.theme.primaryColor,
                  ),
                  onTap: bloc.messenger.call(),
                ),
                const Divider(),
                const MySpacer(size: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
