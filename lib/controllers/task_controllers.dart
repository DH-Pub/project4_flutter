import 'package:dio/dio.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/models/task.dart';
import 'package:proj4_flutter/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskController {
  Dio dio = Dio();
  Api taskApi = Api();
  late SharedPreferences prefs;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<List<Task>?> getTaskByUser(String userId, String projectId) async {
    List<Task>? tasks;
    await taskApi.api.get(
      API_CONSTANTS.myTasks,
      queryParameters: {
        "projectId": projectId,
        "userId": userId,
      },
    ).then((value) {
      List<dynamic> data = value.data;
      tasks = [];
      for (Map<String, dynamic> t in data) {
        Task task = Task.fromJson(t);
        tasks!.add(task);
      }
    }).catchError((err) {
      print(err.toString());
      return null;
    });
    return tasks;
  }

  Future<List<Task>?> getAllTasks() async {
    List<Task>? tasks;
    await taskApi.api
        .get(
      "${API_CONSTANTS.task}/getAll",
    )
        .then((value) {
      List<dynamic> data = value.data;
      tasks = [];
      for (Map<String, dynamic> t in data) {
        Task task = Task.fromJson(t);
        tasks!.add(task);
      }
    }).catchError((err) {
      print(err.toString());
      return null;
    });
    return tasks;
  }
}
