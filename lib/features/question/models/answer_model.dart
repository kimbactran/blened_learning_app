import 'package:blended_learning_appmb/features/personalization/models/user_model.dart';

class AnswerModel {
  String? createdAt;
  String? updatedAt;
  String? id;
  String? content;
  String? parentId;
  UserModel? user;
  int? numUpVote;
  int? numDownVote;
  bool? isUpVote;
  bool? isDownVote;
  String? postId;

  AnswerModel(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.content,
      this.parentId,
      this.user,
      this.numUpVote,
      this.numDownVote,
      this.isUpVote,
      this.isDownVote,
      this.postId});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    content = json['content'];
    parentId = json['parentId'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    numUpVote = json['numUpVote'];
    numDownVote = json['numDownVote'];
    isUpVote = json['isUpVote'];
    isDownVote = json['isDownVote'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['content'] = this.content;
    data['parentId'] = this.parentId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['numUpVote'] = this.numUpVote;
    data['numDownVote'] = this.numDownVote;
    data['isUpVote'] = this.isUpVote;
    data['isDownVote'] = this.isDownVote;
    data['postId'] = this.postId;
    return data;
  }
}
