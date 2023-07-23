class Project {
  String id = '';
  String name = '';
  String teamId = '';
  String createAt = '';

  Project(this.id, this.name, this.teamId, this.createAt);
  Project.noArgs();

  Project.fromJson(Map<String, dynamic> project) {
    id = project["id"] ?? '';
    name = project["name"] ?? '';
    teamId = project["teamId"] ?? '';
    createAt = project["CreateAt"] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'teamId': teamId,
      'createAt': createAt,
    };
  }
}

class ProjectDetail {
  String id = '';
  String name = '';
  String teamId = '';
  String createAt = '';

  ProjectDetail(this.id, this.name, this.teamId, this.createAt);

  ProjectDetail.fromJson(Map<String, dynamic> projectDetails) {
    id = projectDetails["id"] ?? '';
    name = projectDetails["name"] ?? '';
    teamId = projectDetails["teamId"] ?? '';
    createAt = projectDetails["CreateAt"] ?? '';
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'teamId': teamId,
      'createAt': createAt,
    };
  }
}
