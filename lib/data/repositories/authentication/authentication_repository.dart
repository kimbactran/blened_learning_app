import 'dart:convert';

import 'package:blended_learning_appmb/features/authentication/models/authenticaion_model.dart';
import 'package:blended_learning_appmb/features/authentication/models/token_model.dart';
import 'package:blended_learning_appmb/features/personalization/models/user_model.dart';
import 'package:blended_learning_appmb/utils/http/api.dart';
import 'package:blended_learning_appmb/utils/http/http_client.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  AuthenticationModel _auth = AuthenticationModel();
  UserModel user = UserModel();
  TokenModel token = TokenModel();
  // Variable
  Future<void> login(String email, String password) async {
    try {
      Map body = {
        'email': email,
        'password': password,
      };
      var response = await LHttpHelper.post(LApi.authApi.loginAuth, body, '');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _auth = AuthenticationModel.fromJson(data);
        user = _auth.user!;
        token = _auth.token!;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      throw 'Something went wrong when login. Please try again!, ${e.toString()}';
    }
  }
}
