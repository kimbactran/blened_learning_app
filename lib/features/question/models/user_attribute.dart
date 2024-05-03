import '../../personalization/models/user_model.dart';

class UserAttributeModel{
  UserModel? user;
  int? numQuestion;
  int? numAnswer;
  int? numLike;
  int? numDislike;

  UserAttributeModel({
    this.user,
    this.numQuestion,
    this.numAnswer,
    this.numLike,
    this.numDislike,
});

  static UserAttributeModel empty() => UserAttributeModel();
}