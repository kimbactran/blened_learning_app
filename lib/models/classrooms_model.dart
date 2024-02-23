class ClassroomModel {
  String? id;
  String? title;
  String? resources;
  String? status;

  ClassroomModel({this.id, this.title, this.resources, this.status});

  ClassroomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    resources = json['resources'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['resources'] = this.resources;
    data['status'] = this.status;
    return data;
  }
}

class Classroom {
  String? createdAt;
  String? updatedAt;
  String? id;
  String? title;
  String? resources;
  String? status;

  Classroom(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.title,
      this.resources,
      this.status});

  Classroom.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    title = json['title'];
    resources = json['resources'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['title'] = this.title;
    data['resources'] = this.resources;
    data['status'] = this.status;
    return data;
  }
}
