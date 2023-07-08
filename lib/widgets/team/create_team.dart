import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/routes/route_utils.dart';

class CreateTeamForm extends StatefulWidget {
  const CreateTeamForm({super.key});

  @override
  State<CreateTeamForm> createState() => _CreateTeamFormState();
}

class _CreateTeamFormState extends State<CreateTeamForm> {
  TeamController teamCtrl = TeamController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: teamCtrl.teamNameController,
          decoration: const InputDecoration(
            labelText: "Team name",
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          maxLines: null,
          controller: teamCtrl.descriptionController,
          decoration: const InputDecoration(
            labelText: "Description",
          ),
        ),
        const SizedBox(height: 20),
        Text(
          teamCtrl.errMsg,
          style: const TextStyle(color: Colors.red),
        ),
        ElevatedButton(
          onPressed: () {
            teamCtrl.createTeam().then((_) {
              GoRouter.of(context).goNamed(APP_PAGE.home.toName);
            });
          },
          child: const Text(
            "Create Team",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
