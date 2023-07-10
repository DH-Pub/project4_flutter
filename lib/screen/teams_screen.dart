import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/models/team.dart';
import 'package:proj4_flutter/shared/gradient_scaffold.dart';
import 'package:proj4_flutter/widgets/team/create_team.dart';
import 'package:proj4_flutter/widgets/team/teams_list.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  List<UserTeam>? teams;
  bool isCreate = false;
  Future getTeams() async {
    TeamController teamController = TeamController();
    teams = await teamController.getUserTeams();
    setState(() {});
  }

  Widget mainContent = const CreateTeamForm();

  @override
  void initState() {
    getTeams().then((_) {
      if (teams == null) {
        mainContent = const Text(
          "Error",
          style: TextStyle(color: Colors.red),
        );
      } else {
        if (teams!.isNotEmpty) {
          mainContent = TeamsList(teams: teams!);
        } else {
          isCreate = true;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    if (teams == null) {
      mainContent = const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      );
    } else {
      if (teams!.isNotEmpty) {
        mainContent = TeamsList(teams: teams!);
      }
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GradientScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(184, 184, 184, 184),
                    blurRadius: 3.0,
                    offset: Offset(2.0, 2.0),
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        child: isCreate
                            ? IconButton(
                                alignment: Alignment.topRight,
                                onPressed: () {
                                  setState(() {
                                    isCreate = false;
                                  });
                                },
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  color: Color.fromARGB(157, 158, 158, 158),
                                ),
                              )
                            : TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    isCreate = true;
                                  });
                                },
                                icon: const Icon(Icons.add),
                                label: const Text("Create a Team"),
                              ),
                      ),
                    ],
                  ),
                  isCreate
                      ? const CreateTeamForm()
                      : SizedBox(
                          height: height - 100 < 550 ? height - 100 : 550,
                          child: mainContent,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
