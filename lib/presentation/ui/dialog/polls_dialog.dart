import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/serializer/poll/polls_response.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/uiModel/profile/UserModel.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../viewModels/update/UpdateViewModel.dart';

class PollsDialog extends StatelessWidget {
  const PollsDialog({
    Key? key,
    required this.polls,
    required this.force,
  }) : super(key: key);
  final PollsResponse polls;
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
                    'نظرسنجی فعالی برای شما وجود دارد',
                    style: context.textTheme.titleMedium,
                  ),
                  const MySpacer(size: 20),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          GetIt.I
                              .get<NavigationServiceImpl>()
                              .navigateTo(AppRoutes.polls, polls);
                        },
                        child: const Text('شرکت در نظر سنجی'),
                      ),
                      if (!force)
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('بعدا شرکت میکنم'),
                        ),
                    ],
                  ),
                  const MySpacer(size: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
