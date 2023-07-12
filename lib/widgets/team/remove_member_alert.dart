import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/models/team_member.dart';

class RemoveMemberAlert extends StatelessWidget {
  final Function getAllMems;
  final TeamMemberDetail mem;
  const RemoveMemberAlert({super.key, required this.getAllMems, required this.mem});

  @override
  Widget build(BuildContext context) {
    TeamController teamController = TeamController();
    return AlertDialog(
      title: Center(
        child: Column(
          children: [
            const Text(
              "Do you want to remove this member?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              mem.username,
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 5),
            Text(
              mem.email,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.all(8),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            teamController.removeMember(mem.teamMemberId).then((value) {
              if (value == true) {
                getAllMems();
                Navigator.pop(context);
              }
            });
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
  }
}
