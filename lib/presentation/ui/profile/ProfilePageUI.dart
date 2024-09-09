import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/data/serializer/user/UserInfoSerializer.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:kanooniha/presentation/uiModel/profile/UserModel.dart';

import '../../../core/app/AndroidPackageInfoUseCase.dart';
import '../../states/app_state.dart';
import '../../uiModel/profile/LogoutProfileMenu.dart';
import '../../uiModel/profile/ProfileMenuModel.dart';
import '../../uiModel/profile/ProfileObject.dart';
import '../../uiModel/update/AndroidPackageInfoModel.dart';
import '../../viewModels/profile/ProfileViewModel.dart';
import '../dialog/LogoutDialog.dart';

class ProfilePageUI extends StatelessWidget {
  const ProfilePageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ProfileViewModel(AppState.idle),
      builder: (bloc, state) {
        return Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserAppBarWidget(state: state,onReloadClick: bloc.onReloadClick),
              const MySpacer(size: 30),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ProfileMenuItemView(
                        model: ProfileObject.menu.elementAt(index));
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: ProfileObject.menu.length,
                ),
              ),
              const MySpacer(),
              FutureBuilder(
                future: AndroidPackageInfo.invoke(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data is AndroidPackageInfoModel) {
                    AndroidPackageInfoModel? model = snapshot.data;
                    return Text(model?.versionName ?? '',
                        textAlign: TextAlign.center);
                  }
                  return const SizedBox();
                },
              ),
              const MySpacer(),
            ],
          ),
        );
      },
    );
  }
}

class UserAppBarWidget extends StatelessWidget {
  const UserAppBarWidget({
    super.key,
    required this.state, required this.onReloadClick,
  });

  final AppState state;
  final Function() onReloadClick;

  @override
  Widget build(BuildContext context) {
    return ConditionalUI<UserInfoSerializer>(
      onReloadClick: onReloadClick,
      skeleton: const SizedBox(
        height: 200,
        child: Center(child: MyLoader(color: Colors.blue)),
      ),
      state: state,
      onSuccess: (userData) {
        var userModel = userData.createUserModel();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MySpacer(size: 20),
            Container(
              padding: const EdgeInsets.all(.5),
              width: 120,
              height: 120,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: context.theme.primaryColor.withAlpha(99),
                  blurStyle: BlurStyle.outer,
                  spreadRadius: .5,
                  blurRadius: 20.0,
                )
              ]),
              child: CircleAvatar(
                backgroundColor: context.theme.primaryColor.withAlpha(60),
                child: Icon(
                  userModel.iconData,
                  color: Colors.grey.shade50,
                  size: 70,
                ),
              ),
            ),
            const MySpacer(
              size: 20,
            ),
            Text(
              userModel.fullName,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const MySpacer(),
            Text(
              userModel.paye,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w100),
            ),
            const MySpacer(),
            Text(
              userModel.currentYear,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w100),
            ),
          ],
        );
      },
    );
  }
}

class ProfileMenuItemView extends StatelessWidget {
  const ProfileMenuItemView({Key? key, required this.model}) : super(key: key);
  final ProfileMenuModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      title: Text(model.getName),
      trailing: const Icon(CupertinoIcons.right_chevron),
      enabled: true,
      onTap: () async {
        if (model is LogoutProfileMenu) {
          Get.dialog(const LogoutDialog());
        } else {
          Get.toNamed(model.getPath);
        }
      },
      leading: Icon(model.getIcon),
      iconColor: Colors.blue.shade200,
    );
  }
}
