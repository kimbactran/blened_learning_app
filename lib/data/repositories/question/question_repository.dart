import 'dart:convert';
import 'dart:io';

import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:blended_learning_appmb/features/question/models/tag_model.dart';
import 'package:blended_learning_appmb/utils/http/api.dart';
import 'package:blended_learning_appmb/utils/http/http_client.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class QuestionRepository extends GetxController {
  static QuestionRepository get instance => Get.find();

  // Variable
  final deviceStorage = GetStorage();
  Future<List<QuestionModel>> getQuestionInClass(String classId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.postApi.postInClassroom + '/${classId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList
            .map((question) =>
                QuestionModel.fromJsonWithClass(question, classId))
            .toList();
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<QuestionModel>> getQuestionInClassWithSort(
      String classId, String sort) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.postApi.postInClassroom + '/${classId}?order=${sort}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList
            .map((question) =>
                QuestionModel.fromJsonWithClass(question, classId))
            .toList();
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<QuestionModel>> getQuestionByUser(
      List<ClassModel> classes) async {
    try {
      List<QuestionModel> allQuestions = [];
      for (var course in classes) {
        // Lấy lớp
        List<QuestionModel> questions = await getQuestionInClass(course.id!);
        allQuestions.addAll(questions);
      }
      return allQuestions;
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<QuestionModel>> getQuestionOfUser(
      List<ClassModel> classes) async {
    try {
      String userId = deviceStorage.read('User Id');
      List<QuestionModel> allQuestions = [];
      for (var course in classes) {
        // Lấy lớp
        List<QuestionModel> questions = await getQuestionInClass(course.id!);
        questions.forEach((question) {
          if (question.user?.id == userId) {
            allQuestions.add(question);
          }
        });
      }
      return allQuestions;
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<QuestionModel>> getQuestionOfTag(
      List<ClassModel> classes, TagModel tag) async {
    try {
      List<QuestionModel> allQuestions = [];
      for (var course in classes) {
        // Lấy lớp
        List<QuestionModel> questions = await getQuestionInClass(course.id!);
        questions.forEach((question) {
          if (question.tags != null &&
              question.tags!.any((tagCheck) => tagCheck.tag == tag.tag)) {
            allQuestions.add(question);
          }
        });
      }
      return allQuestions;
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<QuestionModel>> getQuestionsOfTag(
      String classId, TagModel tag) async {
    try {
      List<QuestionModel> allQuestions = [];

      List<QuestionModel> questions = await getQuestionInClass(classId);
      questions.forEach((question) {
        if (question.tags != null &&
            question.tags!.any((tagCheck) => tagCheck.tag == tag.tag)) {
          allQuestions.add(question);
        }
      });

      return allQuestions;
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<String> numberQuestionInClass(String classId) async {
    try {
      List<QuestionModel> questions = await getQuestionInClass(classId);
      return questions.length.toString();
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<QuestionModel> getQuestionDetail(String questionId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.postApi.post + '/${questionId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return QuestionModel.fromJson(json);
      }
      throw ('Something went wrong while get question. Status code: ${response.statusCode}');
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<bool> addQuestion(String title, String content, String classroomId,
      List<String> tagIds) async {
    try {
      Map body = {
        'title': title,
        'content': content,
        'classroomId': classroomId,
        'tagIds': tagIds,
        'image_url': '',
      };
      String token = deviceStorage.read('Token');
      var endpoint = LApi.postApi.post;
      var response = await LHttpHelper.post(endpoint, body, token);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return true;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<bool> editQuestion(String postId, String title, String content,
      String classroomId, List<String> tagIds) async {
    try {
      Map body = {
        'title': title,
        'content': content,
        'classroomId': classroomId,
        'tagIds': tagIds
      };
      String token = deviceStorage.read('Token');
      var endpoint = LApi.postApi.post + "/${postId}";
      var response = await LHttpHelper.put(endpoint, body, token);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return true;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<QuestionModel>> searchQuestion(
      String keySearch, String classId, String order) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.postApi.postInClassroom +
          '/${classId}?keySearch=${keySearch}&order=${order}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList
            .map((question) =>
                QuestionModel.fromJsonWithClass(question, classId))
            .toList();
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<bool> likeQuestion(QuestionModel question, bool status) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.postApi.votePost + '/${question.id}';
      Map body = {
        'isUpVote': status,
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

  Future<bool> dislikeQuestion(QuestionModel question, bool status) async {
    try {
      String token = deviceStorage.read('Token');
      Map body = {
        'isDownVote': status,
      };
      var endpoint = LApi.postApi.votePost + '/${question.id}';
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

  Future<List<TagModel>> getTagInClass(String classId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.tagApi.tagInClassroom + '/${classId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList.map((tag) => TagModel.fromJson(tag)).toList();
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<TagModel>> getAllTags(List<ClassModel> classes) async {
    try {
      List<TagModel> tags = [];
      for (var course in classes) {
        // Lấy lớp
        List<TagModel> tag = await getTagInClass(course.id!);
        tags.addAll(tag);
      }
      return tags;
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<void> deleteQuestion(String questionId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.postApi.post + '/${questionId}';
      var response = await LHttpHelper.delete(endpoint, token);
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to delete ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }
}
