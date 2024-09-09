import '../../../common/imports/WidgetImports.dart';
import 'InnerRowWidget.dart';

class KanoonLogo extends StatelessWidget {
  const KanoonLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InnerRowWidget(
      alignment: MainAxisAlignment.center,
      child: SizedBox(
        child: Image.asset(
          'assets/kanoon_icon.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
