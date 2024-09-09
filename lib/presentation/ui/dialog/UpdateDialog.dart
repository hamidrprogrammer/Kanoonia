import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/uiModel/profile/UserModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../../domain/useCase/home/StartupTaskUseCase.dart';
import '../../viewModels/update/UpdateViewModel.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({
    Key? key,
    required this.link,
    required this.force,
  }) : super(key: key);
  final String link;
  final bool force;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => UpdateViewModel(AppState.idle),
      builder: (bloc, state) {
        return WillPopScope(
          onWillPop: () async => !force,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            insetPadding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            child: Padding(
              padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      FutureBuilder(
                        future: bloc.getUserModel(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data is UserModel) {
                            var userModel = snapshot.data as UserModel;
                            return Text(
                              '${userModel.fullName.isNotEmpty ? userModel.fullName : 'کانونی'} عزیز',
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                  const MySpacer(size: 20),
                  Text(
                    'نسخه جدید موجود است لطفا بروزرسانی کنید',
                    style: context.textTheme.titleMedium,
                  ),
                  const MySpacer(size: 20),
                  ElevatedButton(
                      onPressed: () {
                        _launchUrl(link);
                      },
                      child: const Text('بروزرسانی')),
                  const MySpacer(size: 20),
                ],
              ),
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
    return launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
  }
}
