import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/data/serializer/user/UserInfoSerializer.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:kanooniha/presentation/uiModel/profile/UserModel.dart';
import 'package:kanooniha/presentation/viewModels/profile/user_appBar_viewModel.dart';

class UserAppBarUi extends StatelessWidget {
  const UserAppBarUi({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => UserAppBarViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<UserInfoSerializer>(
          onReloadClick: bloc.onReloadClick,
          showError: false,
          skeleton: const MyLoader(color: Colors.blue),
          state: state,
          onSuccess: (userData) {
            var userModel = userData.createUserModel();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    child: Icon(CupertinoIcons.person_alt_circle_fill),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel.fullName,
                        style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(userModel.paye,
                          style: context.textTheme.displaySmall
                              ?.copyWith(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
