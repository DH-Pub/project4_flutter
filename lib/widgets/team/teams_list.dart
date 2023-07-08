import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/models/team.dart';
import 'package:proj4_flutter/routes/route_utils.dart';

class TeamsList extends StatelessWidget {
  final List<UserTeam> teams;
  const TeamsList({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: ElevatedButton(
          onPressed: () {
            Team team = Team(
              teams[index].teamId,
              teams[index].teamName,
              teams[index].teamDescription,
              teams[index].teamCreatedAt,
            );
            TeamController teamController = TeamController();
            teamController.setTeamInPrefs(team).then((_) {
              teamController.getCurrentMember().then((value) {
                // GoRouter.of(context).goNamed(APP_PAGE.home.toName);
                context.goNamed(APP_PAGE.home.toName);
              });
            });
          },
          child: Text(
            teams[index].teamName,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
