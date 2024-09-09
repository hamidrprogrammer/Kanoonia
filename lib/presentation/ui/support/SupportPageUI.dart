import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:kanooniha/presentation/ui/main/custom_leasing.dart';

import '../../../common/appCommons/appRoutes.dart';
import '../../../common/imports/WidgetImports.dart';
import '../../../core/navigationService/NavigationService.dart';

class SupportPageUI extends StatelessWidget {
  const SupportPageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حساب کاربری و پشتیبانی'),
        leading: const CustomLeading(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MySpacer(
            size: 20,
          ),
          ListTile(
            title: Text('پیام ها', style: context.textTheme.titleSmall),
            trailing: Icon(CupertinoIcons.right_chevron),
            leading: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: context.theme.primaryColor.withAlpha(50),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.message,
                color: context.theme.primaryColor,
                size: 20,
              ),
            ),
            onTap: () {
              GetIt.I
                  .get<NavigationServiceImpl>()
                  .navigateTo(AppRoutes.supportMessages);
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'درخواست پشتیبانی',
              style: context.textTheme.titleSmall,
            ),
            trailing: Icon(CupertinoIcons.right_chevron),
            leading: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: context.theme.primaryColor.withAlpha(50),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.headphones_battery,
                color: context.theme.primaryColor,
                size: 20,
              ),
            ),
            onTap: () {
              GetIt.I
                  .get<NavigationServiceImpl>()
                  .navigateTo(AppRoutes.addTicketPage);
            },
          ),

        ],
      ),
    );
  }
}
