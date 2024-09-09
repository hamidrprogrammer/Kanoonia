import 'package:get/get.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:lottie/lottie.dart';

class EmptyPageUI extends StatelessWidget {
  const EmptyPageUI({
    Key? key,
    this.msg = 'اطلاعاتی یافت نشد',
  }) : super(key: key);
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/empty.json',
              repeat: false, alignment: Alignment.center, height: 150),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              msg,
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
