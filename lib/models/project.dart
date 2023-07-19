class Project {
  String? id;
  String? name;
  Team? team;

  Project({this.id, this.name, this.team});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    return data;
  }
}

class Team {
  String? id;
  String? teamName;
  String? description;
  String? createdAt;

  Team({this.id, this.teamName, this.description, this.createdAt});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamName = json['teamName'];
    description = json['description'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teamName'] = this.teamName;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
