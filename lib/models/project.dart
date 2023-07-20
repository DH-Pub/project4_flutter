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





// class Project {
//   String? id;
//   String? name;
//   Team? team;

//   Project({this.id, this.name, this.team});

//   Project.fromJson(Map<String, dynamic> project) {
//     id = project['id'];
//     name = project['name'];
//     team = project['team'] != null ? new Team.fromJson(project['team']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     if (this.team != null) {
//       data['team'] = this.team!.toJson();
//     }
//     return data;
//   }
// }



// class Team {
//   String? id;
//   String? teamName;
//   String? description;
//   String? createdAt;

//   Team({this.id, this.teamName, this.description, this.createdAt});

//   Team.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     teamName = json['teamName'];
//     description = json['description'];
//     createdAt = json['createdAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['teamName'] = this.teamName;
//     data['description'] = this.description;
//     data['createdAt'] = this.createdAt;
//     return data;
//   }
// }
