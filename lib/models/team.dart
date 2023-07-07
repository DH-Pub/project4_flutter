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
