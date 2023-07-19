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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['bio'] = this.bio;
    data['pic'] = this.pic;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
