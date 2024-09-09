import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:kanooniha/presentation/uiModel/home/HomeNavigationModel.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    Key? key,
    required this.items,
    required this.onClick,
    required this.selectedIndex,
  }) : super(key: key);
  final List<HomeNavigationModel> items;
  final Function(HomeNavigationModel) onClick;
  final HomeNavigationModel selectedIndex;

  @override
  Widget build(BuildContext context) {
    return AppBar(
    centerTitle: true,
    title: Text(selectedIndex.getName),
      actions: items.map((hbnI) {
        return InkWell(
          onTap: () {
            onClick.call(hbnI);
          },
          child: Padding(
            padding: 8.dpeh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                b.Badge(
                  badgeContent: Text(
                    hbnI.getBadge,
                    style: const TextStyle(color: Colors.white),
                  ),
                  showBadge: (hbnI.getBadge.isBlank == false),
                  child: Icon(
                    hbnI.getIcon,
                    color:
                        selectedIndex == hbnI ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
