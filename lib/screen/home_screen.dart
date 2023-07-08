import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/models/team.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Team team = Team('', '', '', '');
  late TeamController teamController = TeamController();
  @override
  void initState() {
    teamController.initPrefs().then((_) {
      team = teamController.getTeamInPrefs();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(team.teamName),
        ],
      ),
    );
  }
}
