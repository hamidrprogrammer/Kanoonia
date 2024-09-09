import 'package:kanooniha/common/appCommons/AppConfiguration.dart';
import 'package:kanooniha/presentation/uiModel/update/AndroidPackageInfoModel.dart';

class AndroidPackageInfo {
  static Future<AndroidPackageInfoModel> invoke() async {
    return AndroidPackageInfoModel(
        versionCode: AppConfiguration.versionCode.toString(),
        versionName: AppConfiguration.versionName);
  }
}
