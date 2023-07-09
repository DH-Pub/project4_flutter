// ignore_for_file: camel_case_types

import 'package:proj4_flutter/routes/route_utils.dart';

enum MENU_DRAWER_LINKS { chooseTeam, teamDetail, userSettings }

extension LinksExtension on MENU_DRAWER_LINKS {
  static Map<MENU_DRAWER_LINKS, String> goNamed = {
    MENU_DRAWER_LINKS.chooseTeam: APP_PAGE.userTeams.toName,
    MENU_DRAWER_LINKS.teamDetail: APP_PAGE.team.toName,
    MENU_DRAWER_LINKS.userSettings: APP_PAGE.account.toName,
  };
  static Map<MENU_DRAWER_LINKS, String> title = {
    MENU_DRAWER_LINKS.chooseTeam: "Your Teams",
    MENU_DRAWER_LINKS.teamDetail: "Team Details",
    MENU_DRAWER_LINKS.userSettings: "User Settings",
  };
}
