import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/storage_key.dart';
import 'package:proj4_flutter/models/project_1.dart';
import 'package:proj4_flutter/models/team.dart';
import 'package:proj4_flutter/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proj4_flutter/constants/api_const.dart';

class ProjectController {
  Api projectApi = Api();
  late SharedPreferences prefs;
  TextEditingController projectNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? errMsg = "";

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Team getTeamInPrefs() {
    return Team.fromJson(json.decode(prefs.getString(StorageKey.team) ?? ''));
  }

  ProjectDetail getCurrentProjectInPrefs() {
    return ProjectDetail.fromJson(
        json.decode(prefs.getString(StorageKey.currentProject) ?? ''));
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

  Future<List<ProjectDetail>?> getAllProjects() async {
    List<ProjectDetail>? projects;
    await projectApi.api.get("${API_CONSTANTS.project}/getAll").then((value) {
      List<dynamic> data = value.data;
      projects = [];
      for (Map<String, dynamic> m in data) {
        ProjectDetail project = ProjectDetail.fromJson(m);
        projects!.add(project);
      }
    }).catchError((e) {
      errMsg = e.response.data;
      return null;
    });
    return projects;
  }

  Future<ProjectDetail?> getCurrentProject(String id) async {
    ProjectDetail? currentProject;
    await projectApi.api.get("${API_CONSTANTS.project}/get/$id").then((value) {
      currentProject = currentProject = ProjectDetail.fromJson(value.data);
      prefs.setString(
        StorageKey.currentProject,
        json.encode(currentProject!.toJson()),
      );
    }).catchError((e) {
      errMsg = e.response.data;
    });
    return currentProject;
  }

  Future<Project?> addProject(String name) async {
    if (name.trim().isEmpty) {
      errMsg = "Please enter a valid name";
      return null;
    }
    Project? project;
    String teamId;
    await initPrefs();
    teamId = getTeamInPrefs().id;
    await projectApi.api
        .post("${API_CONSTANTS.project}/create", data: {
          "name": name,
          "teamId": teamId,
        })
        .then((value) => project = Project.fromJson(value.data))
        .catchError((e) {
          errMsg = e.response.data;
          return Project.noArgs();
        });
    return project;
  }

  Future<bool?> removeProject(id) async {
    bool? res;
    await projectApi.api
        .delete("${API_CONSTANTS.project}/$id")
        .then((value) => res = value.data)
        .catchError((e) {
      errMsg = e.response.data;
      return null;
    });
    return res;
  }

  // Future<Project?> updateProject(id) async {
  //   if (projectNameController.text.trim().isEmpty) {
  //     errMsg = "Team name cannot be empty";
  //     return null;
  //   }
  //   Project? project;
  //   await projectApi.api.put("${API_CONSTANTS.team}/$id", data: {
  //     "id": id,
  //     "teamName": projectNameController.text,
  //     "description": descriptionController.text,
  //   }).then((value) async {
  //     project = Project.fromJson(value.data);
  //     prefs = await SharedPreferences.getInstance();
  //     prefs.setString(
  //       StorageKey.team,
  //       json.encode(project!.toJson()),
  //     );
  //     await getAllProjects();
  //   }).catchError((err) {
  //     errMsg = err.response.data;
  //     return null;
  //   });
  //   return project;
  // }
}
