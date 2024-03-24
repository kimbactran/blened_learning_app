import 'package:blended_learning_appmb/features/authentication/models/token_model.dart';
import 'package:blended_learning_appmb/features/personalization/models/user_model.dart';

class AuthenticationModel {
  UserModel? user;
  TokenModel? token;

  AuthenticationModel({this.user, this.token});

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    token =
        json['token'] != null ? new TokenModel.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    return data;
  }
}
