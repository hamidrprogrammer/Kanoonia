import 'package:badges/badges.dart' as b;
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/presentation/uiModel/home/HomeNavigationModel.dart';

class HomeNavigationUI extends StatelessWidget {
  const HomeNavigationUI({
    Key? key,
    required this.menu,
    required this.onHomeIndexChange,
    required this.currentIndex,
  }) : super(key: key);
  final List<HomeNavigationModel> menu;
  final Function(HomeNavigationModel) onHomeIndexChange;
  final HomeNavigationModel currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: .5,
      backgroundColor: Colors.grey.shade50,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      selectedItemColor:
          absIndex == -1 ? Colors.grey : context.theme.primaryColor,
      items: menu.map(
        (hbnI) {
          return BottomNavigationBarItem(
            icon: b.Badge(
              badgeContent: Text(
                hbnI.getBadge,
                style: const TextStyle(color: Colors.white),
              ),
              showBadge: (hbnI.getBadge.isBlank == false),
              child: Icon(hbnI.getIcon),
            ),
            label: hbnI.getName,
          );
        },
      ).toList(),
      currentIndex: index,
      onTap: (value) {
        onHomeIndexChange.call(
          menu[value],
        );
      },
    );
  }

  int get absIndex {
    return menu.indexWhere((element) => element == currentIndex);
  }

  int get index {
    var index = absIndex;
    return index == -1 ? 0 : index;
  }
}
