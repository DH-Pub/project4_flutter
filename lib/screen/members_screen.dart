import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/team_member_role.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/models/team_member.dart';
import 'package:proj4_flutter/routes/route_utils.dart';
import 'package:proj4_flutter/shared/menu_bottom.dart';
import 'package:proj4_flutter/shared/menu_drawer.dart';
import 'package:proj4_flutter/widgets/team/member_add.dart';
import 'package:proj4_flutter/widgets/team/members_list.dart';
import 'package:proj4_flutter/widgets/team/remove_member_alert.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  TeamController teamController = TeamController();
  TeamMemberDetail currentMember = TeamMemberDetail(0, '', '', '', '', '', '', '', '');
  bool isAdmin = false;
  bool hasAuth = false;

  Widget mainContent = const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
    ],
  );

  Future<void> _showRemoveDialog(
    context,
    TeamMemberDetail mem,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return RemoveMemberAlert(getAllMems: getAllMems, mem: mem);
      },
    );
  }

  void getAllMems() async {
    teamController.getAllMembersDetails().then((value) {
      if (value == null) {
        mainContent = const Text(
          "Error",
          style: TextStyle(color: Colors.red),
        );
      } else {
        mainContent = MembersList(
          members: value,
          showRemoveDialog: _showRemoveDialog,
          hasAuth: hasAuth,
          currentMember: currentMember,
        );
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    teamController.initPrefs().then((_) {
      currentMember = teamController.getCurrentMemberInPrefs();
      isAdmin = currentMember.teamMemberRole == TeamMemberRole.CREATOR.name ||
          currentMember.teamMemberRole == TeamMemberRole.ADMINISTRATOR.name;
      hasAuth = currentMember.teamMemberRole == TeamMemberRole.CREATOR.name ||
          currentMember.teamMemberRole == TeamMemberRole.ADMINISTRATOR.name;
      getAllMems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(APP_PAGE.members.toTitle),
        ),
        drawer: const MenuDrawer(),
        bottomNavigationBar: const MenuBottom(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              isAdmin ? MemberAdd(getAllMems: getAllMems) : const SizedBox(),
              const SizedBox(height: 20),
              Expanded(
                child: mainContent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
