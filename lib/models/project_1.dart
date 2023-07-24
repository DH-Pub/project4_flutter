class Project {
  String id = '';
  String name = '';
  String team_id = '';
  String createAt = '';

  Project(this.id, this.name, this.team_id, this.createAt);
  Project.noArgs();

  Project.fromJson(Map<String, dynamic> project) {
    id = project["id"] ?? '';
    name = project["name"] ?? '';
    team_id = project["team_id"] ?? '';
    createAt = project["CreateAt"] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'team_id': team_id,
      'createAt': createAt,
    };
  }
}

class ProjectDetail {
  String id = '';
  String name = '';
  String team_id = '';
  String createAt = '';

  ProjectDetail(this.id, this.name, this.team_id, this.createAt);

  ProjectDetail.fromJson(Map<String, dynamic> projectDetails) {
    id = projectDetails["id"] ?? '';
    name = projectDetails["name"] ?? '';
    team_id = projectDetails["team_id"] ?? '';
    createAt = projectDetails["CreateAt"] ?? '';
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'team_id': team_id,
      'createAt': createAt,
    };
  }
}
