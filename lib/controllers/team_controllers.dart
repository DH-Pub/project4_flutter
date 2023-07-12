import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/constants/storage_key.dart';
import 'package:proj4_flutter/models/team.dart';
import 'package:proj4_flutter/models/team_member.dart';
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

  TeamMemberDetail getCurrentMemberInPrefs() {
    return TeamMemberDetail.fromJson(json.decode(prefs.getString(StorageKey.currentMember) ?? ''));
  }

  Future<bool> setTeamInPrefs(Team team) async {
    initPrefs().then((_) {
      prefs.setString(
        StorageKey.team,
        json.encode(team.toJson()),
      );
    }).catchError((e) {
      return null;
    });
    return true;
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
        await getCurrentMember();
        return team;
      } else {
        return null;
      }
    } catch (e) {
      errMsg = "Error";
      return null;
    }
  }

  Future<Team?> updateTeam(id) async {
    if (teamNameController.text.isEmpty) {
      errMsg = "Team name cannot be empty";
      return null;
    }
    try {
      var res = await team.api.put("${API_CONSTANTS.team}/update", data: {
        "id": id,
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
        await getCurrentMember();
        return team;
      } else {
        return null;
      }
    } catch (e) {
      errMsg = "Error";
      return null;
    }
  }

  Future<TeamMemberDetail?> getCurrentMember() async {
    try {
      Team currentTeam = Team.fromJson(json.decode(prefs.getString(StorageKey.team) ?? ''));
      var res = await team.api.get("${API_CONSTANTS.team}/${currentTeam.id}/current-member");
      if (res.statusCode == 200) {
        TeamMemberDetail currentMember = TeamMemberDetail.fromJson(res.data);
        prefs.setString(
          StorageKey.currentMember,
          json.encode(currentMember.toJson()),
        );
        return currentMember;
      } else {
        return null;
      }
    } catch (e) {
      errMsg = "Error";
      return null;
    }
  }

  Future<List<TeamMemberDetail>?> getAllMembersDetails() async {
    try {
      Team currentTeam = Team.fromJson(json.decode(prefs.getString(StorageKey.team) ?? ''));
      var res = await team.api.get("${API_CONSTANTS.team}/${currentTeam.id}/all-members-details");
      if (res.statusCode == 200) {
        List<dynamic> data = res.data;
        List<TeamMemberDetail> members = [];
        for (Map<String, dynamic> m in data) {
          TeamMemberDetail member = TeamMemberDetail.fromJson(m);
          members.add(member);
        }
        return members;
      } else {
        errMsg = "Error";
        return null;
      }
    } catch (e) {
      errMsg = "Error";
      return null;
    }
  }

  Future<TeamMember?> addMember(String email, String teamRole) async {
    try {
      String teamId;
      await initPrefs();
      teamId = getTeamInPrefs().id;
      var res = await team.api.post("${API_CONSTANTS.team}/add-member", data: {
        "email": email,
        "teamId": teamId,
        "role": teamRole,
      });
      if (res.statusCode == 200) {
        TeamMember member = TeamMember.fromJson(res.data);
        return member;
      } else {
        errMsg = "Error";
        return null;
      }
    } catch (e) {
      errMsg = "Error";
      return null;
    }
  }

  Future<bool?> removeMember(id) async {
    try {
      var res = await team.api.delete("${API_CONSTANTS.team}/remove-member/$id");
      if (res.statusCode == 200) {
        return res.data;
      } else {
        errMsg = "Error";
        return null;
      }
    } catch (e) {
      errMsg = "Error";
      return null;
    }
  }
}
