import 'package:kanooniha/common/imports/appImports.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key? key, required this.value}) : super(key: key);
  final double value;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
      strokeWidth: 5,
      backgroundColor: Colors.grey.withOpacity(.5),
    );
  }
}
