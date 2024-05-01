class TagModel {
  String? createdAt;
  String? updatedAt;
  String? id;
  String? tag;
  String? parentId;
  String? type;

  TagModel(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.tag,
      this.parentId,
      this.type});

  static TagModel empty() => TagModel();
  TagModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    tag = json['tag'];
    parentId = json['parentId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['tag'] = this.tag;
    data['parentId'] = this.parentId;
    data['type'] = this.type;
    return data;
  }
}
