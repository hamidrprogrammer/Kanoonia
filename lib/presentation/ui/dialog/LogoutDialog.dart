import 'package:core/storage/shared/LocalSessionImpl.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/ui/WidgetSize.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);
  static const platform = MethodChannel('ir.kanoon.kanooniha.android/messages');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      insetPadding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
      child: Padding(
        padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const MySpacer(),
            Text(
              'آیا میخواهید از حساب خود خارج شوید؟',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const MySpacer(size: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                      onPressed: () async {
                        await GetIt.I.get<LocalSessionImpl>().clearSession();
                        Get.offAllNamed(AppRoutes.login);
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.remove('tokenJwt');
                        await platform.invokeMethod('stopService');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('بله'),
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('خیر'),
                      )),
                ),
                const SizedBox(width: 10)
              ],
            )
          ],
        ),
      ),
    );
  }
}
