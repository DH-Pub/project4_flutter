import 'package:proj4_flutter/models/project.dart';
import 'package:proj4_flutter/models/user.dart';

class Task {
  String? id;
  String? taskName;
  String? description;
  String? brief;
  String? priority;
  String? category;
  int? estimated;
  int? actualHours;
  String? startDate;
  String? endDate;
  String? dueDate;
  String? files;
  String? status;
  int? position;
  String? version;
  User? user;
  String? parentTask;
  Project? project;
  String? statusUpdateAt;

  Task(
      {this.id,
      this.taskName,
      this.description,
      this.brief,
      this.priority,
      this.category,
      this.estimated,
      this.actualHours,
      this.startDate,
      this.endDate,
      this.dueDate,
      this.files,
      this.status,
      this.position,
      this.version,
      this.user,
      this.parentTask,
      this.project,
      this.statusUpdateAt});
  Task.noArgs();
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['taskName'];
    description = json['description'];
    brief = json['brief'];
    priority = json['priority'];
    category = json['category'];
    estimated = json['estimated'];
    actualHours = json['actualHours'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    dueDate = json['dueDate'];
    files = json['files'];
    status = json['status'];
    position = json['position'];
    version = json['version'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    parentTask = json['parentTask'];
    project =
        json['project'] != null ? new Project.fromJson(json['project']) : null;
    statusUpdateAt = json['statusUpdateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['taskName'] = this.taskName;
    data['description'] = this.description;
    data['brief'] = this.brief;
    data['priority'] = this.priority;
    data['category'] = this.category;
    data['estimated'] = this.estimated;
    data['actualHours'] = this.actualHours;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['dueDate'] = this.dueDate;
    data['files'] = this.files;
    data['status'] = this.status;
    data['position'] = this.position;
    data['version'] = this.version;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['parentTask'] = this.parentTask;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    data['statusUpdateAt'] = this.statusUpdateAt;
    return data;
  }
}
