import 'package:core/storage/shared/LocalSessionImpl.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/common/imports/appImports.dart';

import '../../../common/ui/WidgetSize.dart';


class SuccessPollDialog extends StatelessWidget {
  const SuccessPollDialog({Key? key}) : super(key: key);

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
              'پاسخ های شما در نظرسنجی با موفقیت ثبت شد',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const MySpacer(size: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  onPressed: () async {
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('بستن'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
