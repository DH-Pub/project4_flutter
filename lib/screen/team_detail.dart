import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  TextEditingController confirmTxt = TextEditingController();
  String? confirm;
  @override
  void initState() {
    teamController.initPrefs().then((_) {
      team = teamController.getTeamInPrefs();
      teamController.teamNameController.text = team.teamName;
      teamController.descriptionController.text = team.description;
      currentMember = teamController.getCurrentMemberInPrefs();
      isCreator = currentMember.teamMemberRole == TeamMemberRole.CREATOR.name;

      confirm = "I want to delete team ${team.teamName}";
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
        persistentFooterButtons: [
          isCreator
              ? Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: TextButton(
                    onPressed: () {
                      _showDeleteDialog(context);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Future<void> _showDeleteDialog(context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    text: "Please enter ",
                    style: const TextStyle(fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: confirm,
                        style: const TextStyle(
                          fontSize: 14,
                          backgroundColor: Color.fromARGB(255, 190, 190, 190),
                        ),
                      ),
                      const TextSpan(text: " to delete the team"),
                    ],
                  ),
                ),
                TextFormField(
                  enabled: isCreator,
                  controller: confirmTxt,
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.all(8),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                if (confirm == confirmTxt.text) {
                  teamController.deleteTeam(team.id).then((value) {
                    // FocusManager.instance.primaryFocus?.unfocus();
                    if (value == true) {
                      Navigator.pop(context);
                      context.go(APP_PAGE.userTeams.toPath);
                    }
                  });
                }
              },
              child: const Text(
                "Remove",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
