import 'dart:convert';

import 'package:blended_learning_appmb/features/personalization/models/user_model.dart';
import 'package:blended_learning_appmb/utils/http/http_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../features/question/models/message_model.dart';
import '../../../utils/http/api.dart';
import '../authentication/authentication_repository.dart';

class ChatRepository extends GetxController {
  static ChatRepository get instance => Get.find();
  final deviceStorage = GetStorage();
  final authenticationRepository = AuthenticationRepository.instance;

  Future<List<UserModel>> getListUser(String userId) async {
    try {
      String token = deviceStorage.read('Token');
      final users = <UserModel>[];
      var endpoint = LApi.messageApi.message + '/${userId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        for (var userId in data) {
          final user = await authenticationRepository.getUserInfo(userId);
          users.add(user);
        }
        return users;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      throw 'Something went wrong when get list user. Please try again!, ${e.toString()}';
    }
  }

  Future<MessageModel> createMessage(
      String content, String sendUserId, String receiverId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.messageApi.message;
      Map body = {
        "content": content,
        "send_id": sendUserId,
        "receiver_id": receiverId
      };

      var response = await LHttpHelper.post(endpoint, body, token);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final message = MessageModel.fromJson(data);
        return message;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      throw 'Something went wrong when send message. Please try again!, ${e.toString()}';
    }
  }

  Future<List<MessageModel>> getMessages(
      String senderId, String receiverId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint =
          LApi.messageApi.message + '?sendId=$senderId&receiverId=$receiverId';
      print(endpoint);
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<MessageModel> messages =
            data.map((item) => MessageModel.fromJson(item)).toList();
        print(messages.length);
        messages.map((message) => print(message.content));
        return messages;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      throw 'Something went wrong when load messages. Please try again!, ${e.toString()}';
    }
  }
}
