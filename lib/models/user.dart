class User {
  String id = '';
  String email = '';
  String username = '';
  String bio = '';
  String pic = '';
  String createdAt = '';

  User(this.id, this.email, this.username, this.bio, this.pic, this.createdAt);
  User.noArgs();
  User.fromJson(Map<String, dynamic> user) {
    id = user["id"] ?? '';
    email = user["email"] ?? '';
    username = user["username"] ?? '';
    bio = user["bio"] ?? '';
    pic = user["pic"] ?? '';
    createdAt = user["createdAt"] ?? '';
  }
}
