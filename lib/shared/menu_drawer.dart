import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proj4_flutter/constants/colors_const.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/models/team.dart';
import 'package:proj4_flutter/models/team_member.dart';
import 'package:proj4_flutter/services/auth_service.dart';
import 'package:proj4_flutter/shared/menu_drawer_links.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  TeamController teamController = TeamController();
  late Team team = Team('', '', '', '');
  late TeamMemberDetail currentMember = TeamMemberDetail(0, '', '', '', '', '', '', '', '');

  @override
  void initState() {
    teamController.initPrefs().then((_) {
      team = teamController.getTeamInPrefs();
      currentMember = teamController.getCurrentMemberInPrefs();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Drawer(
      backgroundColor: const Color.fromRGBO(17, 24, 39, 1),
      child: ListView(
        children: buildMenuItems(context, authService),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context, AuthService authService) {
    List<Widget> menuItems = [];
    menuItems.add(
      DrawerHeader(
        decoration: const BoxDecoration(color: COLOR_CONST.green),
        child: Text(
          team.teamName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

    for (var links in MENU_DRAWER_LINKS.values) {
      menuItems.add(ListTile(
        title: Text(
          LinksExtension.title[links]!,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        onTap: () {
          context.goNamed(LinksExtension.goNamed[links]!);
        },
      ));
    }

    menuItems.add(ListTile(
      title: const Text(
        'Logout',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      onTap: () {
        authService.logOut();
      },
    ));

    return menuItems;
  }
}
