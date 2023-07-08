class TeamMember {
  int id = 0;
  String userId = '';
  String addedBy = '';
  String teamId = '';
  String role = '';
  String addedAt = '';

  TeamMember(this.id, this.userId, this.addedBy, this.teamId, this.role, this.addedAt);
  TeamMember.fromJson(Map<String, dynamic> teamMember) {
    id = teamMember["id"] ?? 0;
    userId = teamMember["userId"] ?? '';
    addedBy = teamMember["addedBy"] ?? '';
    teamId = teamMember["teamId"] ?? '';
    role = teamMember["role"] ?? '';
    addedAt = teamMember["addedAt"] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'addedBy': addedBy,
      'teamId': teamId,
      'role': role,
      'addedAt': addedAt,
    };
  }
}
