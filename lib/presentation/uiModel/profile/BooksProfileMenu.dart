import 'package:kanooniha/presentation/uiModel/profile/ProfileMenuModel.dart';

class BooksProfileMenu extends ProfileMenuModel {
  @override
  IconData icon() {
    return CupertinoIcons.book_fill;
  }

  @override
  String name() {
    return 'کتاب';
  }

  @override
  String path() {
    return AppRoutes.booksPage;
  }
}
