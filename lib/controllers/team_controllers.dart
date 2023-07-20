import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/constants/storage_key.dart';
import 'package:proj4_flutter/models/team.dart';
import 'package:proj4_flutter/models/team_member.dart';
import 'package:proj4_flutter/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamController {
  Api teamApi = Api();
  late SharedPreferences prefs;
  TextEditingController teamNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? errMsg = "";

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
    List<UserTeam>? teams;
    await teamApi.api.get("${API_CONSTANTS.team}/user").then((value) {
      List<dynamic> data = value.data;
      teams = [];
      for (Map<String, dynamic> t in data) {
        UserTeam team = UserTeam.fromJson(t);
        teams!.add(team);
      }
    }).catchError((err) {
      errMsg = err.response.data;
      return null;
    });
    return teams;
  }

  Future<Team?> createTeam() async {
    if (teamNameController.text.trim().isEmpty) {
      errMsg = "Team name cannot be empty";
      return null;
    }
    Team? team;
    await teamApi.api.post("${API_CONSTANTS.team}/create", data: {
      "teamName": teamNameController.text,
      "description": descriptionController.text,
    }).then((value) async {
      team = Team.fromJson(value.data);
      prefs = await SharedPreferences.getInstance();
      prefs.setString(
        StorageKey.team,
        json.encode(team!.toJson()),
      );
      await getCurrentMember();
    }).catchError((err) {
      errMsg = err.response.data;
      return null;
    });
    return team;
  }

  Future<Team?> updateTeam(id) async {
    if (teamNameController.text.trim().isEmpty) {
      errMsg = "Team name cannot be empty";
      return null;
    }
    Team? team;
    await teamApi.api.put("${API_CONSTANTS.team}/update", data: {
      "id": id,
      "teamName": teamNameController.text,
      "description": descriptionController.text,
    }).then((value) async {
      team = Team.fromJson(value.data);
      prefs = await SharedPreferences.getInstance();
      prefs.setString(
        StorageKey.team,
        json.encode(team!.toJson()),
      );
      await getCurrentMember();
    }).catchError((err) {
      errMsg = err.response.data;
      return null;
    });
    return team;
  }

  Future<bool?> deleteTeam(id) async {
    bool? del;
    await teamApi.api.delete("${API_CONSTANTS.team}/delete/$id").then((value) => del = value.data).catchError((e) {
      errMsg = e.response.data;
      return null;
    });
    return del;
  }

  Future<TeamMemberDetail?> getCurrentMember() async {
    TeamMemberDetail? currentMember;
    Team currentTeam = Team.fromJson(json.decode(prefs.getString(StorageKey.team) ?? ''));
    await teamApi.api.get("${API_CONSTANTS.team}/${currentTeam.id}/current-member").then((value) {
      currentMember = currentMember = TeamMemberDetail.fromJson(value.data);
      prefs.setString(
        StorageKey.currentMember,
        json.encode(currentMember!.toJson()),
      );
    }).catchError((e) {
      errMsg = e.response.data;
    });
    return currentMember;
  }

  Future<List<TeamMemberDetail>?> getAllMembersDetails() async {
    List<TeamMemberDetail>? members;
    Team currentTeam = Team.fromJson(json.decode(prefs.getString(StorageKey.team) ?? ''));
    await teamApi.api.get("${API_CONSTANTS.team}/${currentTeam.id}/all-members-details").then((value) {
      List<dynamic> data = value.data;
      members = [];
      for (Map<String, dynamic> m in data) {
        TeamMemberDetail member = TeamMemberDetail.fromJson(m);
        members!.add(member);
      }
    }).catchError((e) {
      errMsg = e.response.data;
      return null;
    });
    return members;
  }

  Future<TeamMember?> addMember(String email, String teamRole) async {
    if (email.trim().isEmpty) {
      errMsg = "Please enter a valid email";
      return null;
    }
    TeamMember? member;
    String teamId;
    await initPrefs();
    teamId = getTeamInPrefs().id;
    await teamApi.api
        .post("${API_CONSTANTS.team}/add-member", data: {
          "email": email,
          "teamId": teamId,
          "role": teamRole,
        })
        .then((value) => member = TeamMember.fromJson(value.data))
        .catchError((e) {
          errMsg = e.response.data;
          return TeamMember.noArgs();
        });
    return member;
  }

  Future<bool?> removeMember(id) async {
    bool? res;
    await teamApi.api
        .delete("${API_CONSTANTS.team}/remove-member/$id")
        .then((value) => res = value.data)
        .catchError((e) {
      errMsg = e.response.data;
      return null;
    });
    return res;
  }
}
