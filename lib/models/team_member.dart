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

class TeamMemberDetail {
  int teamMemberId = 0;
  String teamId = '';
  String addedBy = '';
  String teamMemberRole = '';
  String addedAt = '';

  String userId = '';
  String email = '';
  String username = '';
  String pic = '';

  TeamMemberDetail(this.teamMemberId, this.teamId, this.addedBy, this.teamMemberRole, this.addedAt, this.userId,
      this.email, this.username, this.pic);
  TeamMemberDetail.fromJson(Map<String, dynamic> memberDetails) {
    teamMemberId = memberDetails["teamMemberId"] ?? 0;
    teamId = memberDetails["teamId"] ?? '';
    addedBy = memberDetails["addedBy"] ?? '';
    teamMemberRole = memberDetails["teamMemberRole"] ?? '';
    addedAt = memberDetails["addedAt"] ?? '';
    userId = memberDetails["userId"] ?? '';
    email = memberDetails["email"] ?? '';
    username = memberDetails["username"] ?? '';
    pic = memberDetails["pic"] ?? '';
  }
  Map<String, dynamic> toJson() {
    return {
      'teamMemberId': teamMemberId,
      'teamId': teamId,
      'addedBy': addedBy,
      'teamMemberRole': teamMemberRole,
      'addedAt': addedAt,
      'userId': userId,
      'email': email,
      'username': username,
      'pic': pic,
    };
  }
}
