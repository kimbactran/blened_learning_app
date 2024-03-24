class UserModel {
  String? createdAt;
  String? updatedAt;
  String? id;
  String? role;
  String? email;
  String? name;
  String? gender;

  UserModel(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.role,
      this.email,
      this.name,
      this.gender});
  String get nameAndRole => '$name - $role';

  UserModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    role = json['role'];
    email = json['email'];
    name = json['name'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['role'] = this.role;
    data['email'] = this.email;
    data['name'] = this.name;
    data['gender'] = this.gender;
    return data;
  }
}
