class Team {
  String id = '';
  String teamName = '';
  String description = '';
  String createdAt = '';

  Team(this.id, this.teamName, this.description, this.createdAt);
  Team.fromJson(Map<String, dynamic> team) {
    id = team["id"] ?? '';
    teamName = team["teamName"] ?? '';
    description = team["description"] ?? '';
    createdAt = team["createdAt"] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'temteName': teamName,
      'description': description,
      'createdAt': createdAt,
    };
  }
}

class UserTeam {
  int teamMemberId = 0;
  String teamId = '';
  String userId = '';
  String teamMemberRole = '';
  String teamName = '';
  String teamDescription = '';
  String teamCreatedAt = '';

  UserTeam(this.teamMemberId, this.teamId, this.userId, this.teamMemberRole, this.teamName, this.teamDescription,
      this.teamCreatedAt);

  UserTeam.fromJson(Map<String, dynamic> userTeam) {
    teamMemberId = userTeam['teamMemberId'] ?? 0;
    teamId = userTeam['teamId'] ?? '';
    userId = userTeam['userId'] ?? '';
    teamMemberRole = userTeam['teamMemberRole'] ?? '';
    teamName = userTeam['teamName'] ?? '';
    teamDescription = userTeam['teamDescription'] ?? '';
    teamCreatedAt = userTeam['teamCreatedAt'] ?? '';
  }
}
