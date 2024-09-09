class AndroidPackageInfoModel {
  final String versionCode, versionName;

  const AndroidPackageInfoModel(
      {required this.versionCode, required this.versionName});

  @override
  String toString() {
    return 'versionCode : $versionCode \n versionName : $versionName';
  }
}
