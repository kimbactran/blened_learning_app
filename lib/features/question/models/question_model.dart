import 'package:blended_learning_appmb/features/personalization/models/user_model.dart';
import 'package:blended_learning_appmb/features/question/models/tag_model.dart';

class QuestionModel {
  String? createdAt;
  String? updatedAt;
  String? id;
  String? title;
  String? content;
  UserModel? user;
  List<TagModel>? tags;
  int? numUpVote;
  int? numDownVote;
  bool? isUpVote;
  bool? isDownVote;

  QuestionModel(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.title,
      this.content,
      this.user,
      this.tags,
      this.numUpVote,
      this.numDownVote,
      this.isUpVote,
      this.isDownVote});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    title = json['title'];
    content = json['content'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['tags'] != null) {
      tags = <TagModel>[];
      json['tags'].forEach((v) {
        tags!.add(TagModel.fromJson(v));
      });
    }
    numUpVote = json['numUpVote'];
    numDownVote = json['numDownVote'];
    isUpVote = json['isUpVote'];
    isDownVote = json['isDownVote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    data['numUpVote'] = this.numUpVote;
    data['numDownVote'] = this.numDownVote;
    data['isUpVote'] = this.isUpVote;
    data['isDownVote'] = this.isDownVote;
    return data;
  }
}
