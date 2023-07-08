import 'package:flutter/material.dart';
import 'package:proj4_flutter/models/team.dart';

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
          onPressed: () {},
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
