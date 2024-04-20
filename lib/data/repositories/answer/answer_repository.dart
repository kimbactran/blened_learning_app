import 'dart:convert';

import 'package:blended_learning_appmb/features/question/models/answer_model.dart';
import 'package:blended_learning_appmb/utils/http/api.dart';
import 'package:blended_learning_appmb/utils/http/http_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AnswerRepository extends GetxController {
  static AnswerRepository get instance => Get.find();

  final deviceStorage = GetStorage();

  Future<List<AnswerModel>> getAnswerOfPost(
      String postId, String classId, String order) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint =
          LApi.commentApi.comment + '?postId=${postId}&classroomId=${classId}&order=${order}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList
            .map((answers) => AnswerModel.fromJson(answers))
            .toList();
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<AnswerModel> getAnswerDetail(String answerId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.commentApi.comment + '/${answerId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return AnswerModel.fromJson(json);
      }
      throw ('Something went wrong while get question. Status code: ${response.statusCode}');
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<void> addComment(String content, String postId, String classId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.commentApi.comment;
      Map data = {
        'postId': postId,
        'classroomId': classId,
        'content': content,
      };
      var response = await LHttpHelper.post(endpoint, data, token);
      if (response.statusCode != 200) {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<void> addAnswerOfAnswer(String content, String postId, String classId, String parentId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.commentApi.comment;
      Map data = {
        'postId': postId,
        'classroomId': classId,
        'content': content,
        'parentId': parentId,
      };
      var response = await LHttpHelper.post(endpoint, data, token);
      if (response.statusCode != 200) {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<void> deleteAnswer(String answerId) async{
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.commentApi.comment + '/${answerId}';
      var response = await LHttpHelper.delete(endpoint, token);
      if(response.statusCode == 200){

      } else {
        throw Exception('Failed to delete ${response.statusCode}');
      }

    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<bool> likeAnswer(AnswerModel answer, bool status) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.commentApi.voteComment + '/${answer.id}';
      Map body = {
        'isUpVote' : status,
      };
      var response = await LHttpHelper.put(endpoint, body, token);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<bool> dislikeAnswer(AnswerModel answer, bool status) async {
    try {
      String token = deviceStorage.read('Token');
      Map body = {
        'isDownVote' : status,
      };
      var endpoint = LApi.commentApi.voteComment + '/${answer.id}';
      var response = await LHttpHelper.put(endpoint, body, token);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }
}
