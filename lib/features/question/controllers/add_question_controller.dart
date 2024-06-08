import 'package:blended_learning_appmb/features/question/controllers/question_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/question/question_repository.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../models/class_model.dart';
import '../models/tag_model.dart';
import 'class_controller.dart';

class AddQuestionController extends GetxController {
  static AddQuestionController get instance => Get.find();

  TextEditingController questionText = TextEditingController();
  final title = TextEditingController();
  RxList<TagModel> tags = <TagModel>[].obs;
  Rx<ClassModel> classSelected = ClassModel.empty().obs;
  List<ClassModel> allClasses = <ClassModel>[].obs;
  RxList<String> images = <String>[].obs;
  final picker = ImagePicker();

  final questionRepository = QuestionRepository.instance;
  final questionController = QuestionController.instance;
  final classController = ClassController.instance;
  final QuillEditorController controller = QuillEditorController();
  final _db = FirebaseFirestore.instance;

  @override
  void onInit() async {
    super.onInit();
    final courses = await classController.getAllClasses();
    allClasses.addAll(courses);
    classSelected.value = courses.first;
    tags.assignAll(await questionRepository.getAllTags(allClasses));
  }

  void setClassSelected(ClassModel value) {
    classSelected.value = value;
  }

  Future<void> addQuestion(String classroomId, List<String> tagIds) async {
    try {
      //LFullScreenLoader.openLoadingDialog(
      //'Loading...', LImages.loaderAnimation);
      if (title.text.trim().isEmpty ||
          title.text.trim().trim().isEmpty ||
          tagIds.isEmpty) {
        LLoader.customToast(
            message: "Please enter full the title, description and tags!");
      } else {
        String? htmlText = await controller.getText();
        bool result = await questionRepository.addQuestion(
            title.text.trim(), htmlText, classroomId, tagIds);
        if (result) {
          Get.back();
          LLoader.successSnackBar(
              title: "Create question successfully",
              message: "Let's check answer");
          questionController.refreshData.toggle();
          controller.clear();
          title.clear();
        } else {
          LFullScreenLoader.stopLoading();
          LLoader.errorSnackBar(
              title: 'Oh Snap!',
              message: 'Something went wrong when add question!');
        }
      }
    } catch (error) {
      LFullScreenLoader.stopLoading();
      LLoader.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }

  void chooseImage() async {
    final image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image != null) {
      final imageUrl = await questionRepository.uploadImage('PostImg/', image);
      images.add(imageUrl);
    }
  }
}
