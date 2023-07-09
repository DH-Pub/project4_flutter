import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proj4_flutter/constants/colors_const.dart';
import 'package:proj4_flutter/routes/route_utils.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switch (index) {
          case 0:
            context.goNamed(APP_PAGE.home.toName);
            break;
          case 1:
            context.goNamed(APP_PAGE.projects.toName);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.task,
            color: COLOR_CONST.grey,
          ),
          label: APP_PAGE.home.toTitle,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.list,
            color: COLOR_CONST.grey,
          ),
          label: APP_PAGE.projects.toTitle,
        ),
      ],
    );
  }
}
