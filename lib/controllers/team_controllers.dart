import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/constants/storage_key.dart';
import 'package:proj4_flutter/models/team.dart';
import 'package:proj4_flutter/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamController {
  Api team = Api();
  late SharedPreferences prefs;
  TextEditingController teamNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String errMsg = "";

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Team getTeamInPrefs() {
    return Team.fromJson(json.decode(prefs.getString(StorageKey.team) ?? ''));
  }

  Future<List<UserTeam>?> getUserTeams() async {
    try {
      var res = await team.api.get("${API_CONSTANTS.team}/user");
      if (res.statusCode == 200) {
        List<dynamic> data = res.data;
        List<UserTeam> teams = [];
        for (Map<String, dynamic> t in data) {
          UserTeam team = UserTeam.fromJson(t);
          teams.add(team);
        }
        return teams;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Team?> createTeam() async {
    if (teamNameController.text.isEmpty) {
      errMsg = "Team name cannot be empty";
      return null;
    }
    try {
      var res = await team.api.post("${API_CONSTANTS.team}/create", data: {
        "teamName": teamNameController.text,
        "description": descriptionController.text,
      });
      if (res.statusCode == 200) {
        Team team = Team.fromJson(res.data);
        prefs = await SharedPreferences.getInstance();
        prefs.setString(
          StorageKey.team,
          json.encode(team.toJson()),
        );
        return team;
      } else {
        return null;
      }
    } catch (e) {
      errMsg = "Error";
      return null;
    }
  }
}
