import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proj4_flutter/constants/colors_const.dart';
import 'package:proj4_flutter/constants/team_member_role.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/models/team.dart';
import 'package:proj4_flutter/models/team_member.dart';
import 'package:proj4_flutter/routes/route_utils.dart';
import 'package:proj4_flutter/shared/menu_bottom.dart';
import 'package:proj4_flutter/shared/menu_drawer.dart';

class TeamDetail extends StatefulWidget {
  const TeamDetail({super.key});

  @override
  State<TeamDetail> createState() => _TeamDetailsStat();
}

class _TeamDetailsStat extends State<TeamDetail> {
  TeamController teamController = TeamController();
  Team team = Team('', '', '', '');
  TeamMemberDetail currentMember = TeamMemberDetail(0, '', '', '', '', '', '', '', '');
  bool isCreator = false;

  @override
  void initState() {
    teamController.initPrefs().then((_) {
      team = teamController.getTeamInPrefs();
      teamController.teamNameController.text = team.teamName;
      teamController.descriptionController.text = team.description;
      currentMember = teamController.getCurrentMemberInPrefs();
      isCreator = currentMember.teamMemberRole == TeamMemberRole.CREATOR.name;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
          title: Text(team.teamName),
          actions: [
            IconButton(
                onPressed: () {
                  context.go(APP_PAGE.members.toPath);
                },
                icon: const Icon(Icons.supervised_user_circle_sharp)),
          ],
        ),
        drawer: const MenuDrawer(),
        bottomNavigationBar: const MenuBottom(),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                enabled: isCreator,
                controller: teamController.teamNameController,
                decoration: const InputDecoration(
                  labelText: "Team name",
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                enabled: isCreator,
                controller: teamController.descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            teamController.updateTeam(team.id).then((value) {
              if (value != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Saved")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                    "Error",
                    style: TextStyle(color: Colors.red),
                  )),
                );
              }
            });
          },
          backgroundColor: COLOR_CONST.green2,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
