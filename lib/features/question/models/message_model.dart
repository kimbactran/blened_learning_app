class MessageModel {
  String? sendId;
  String? content;
  String? receiverId;
  String? createdAt;
  String? updatedAt;
  String? id;

  MessageModel(
      {this.sendId,
        this.content,
        this.receiverId,
        this.createdAt,
        this.updatedAt,
        this.id});

  MessageModel.fromJson(Map<String, dynamic> json) {
    sendId = json['send_id'];
    content = json['content'];
    receiverId = json['receiver_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['send_id'] = this.sendId;
    data['content'] = this.content;
    data['receiver_id'] = this.receiverId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}