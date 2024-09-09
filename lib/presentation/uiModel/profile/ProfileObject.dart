import 'package:kanooniha/presentation/uiModel/profile/AppSupportProfileMenu.dart';

import 'LogoutProfileMenu.dart';
import 'ProfileMenuModel.dart';

class ProfileObject {
  static List<ProfileMenuModel> menu = [
    // PastExamProfileMenu(),
    AppSupportProfileMenu(),
    // WorkBookProfileModel(), this is news profile model
    // AddTargetProfileModel(),
    // MatchProfileMenu(),
    // BooksProfileMenu(),
    LogoutProfileMenu()
  ];
}
