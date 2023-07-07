import 'package:flutter/material.dart';
import 'package:proj4_flutter/models/team.dart';

class TeamsList extends StatelessWidget {
  final List<UserTeam> teams;
  const TeamsList({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ElevatedButton(
          onPressed: () {},
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              teams[index].teamName,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
