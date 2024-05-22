import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/data/repositories/tag_repository/tag_repository.dart';
import 'package:blended_learning_appmb/features/question/models/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';

class TagController extends GetxController {
  static TagController get instance => Get.find();

  final tagRepository = Get.put(TagRepository());
  final tag = TextEditingController();
  RxBool refreshData = true.obs;

  RxList<TagModel> selectedTags = <TagModel>[].obs;
  RxList<TagModel> selectedFreeTags = <TagModel>[].obs;
  RxList<TagModel> selectedSyllabusTags = <TagModel>[].obs;
  RxList<TagModel> allTags = <TagModel>[].obs;

  RxList<TagModel> freeTags = <TagModel>[].obs;
  RxList<TagModel> syllabusTags = <TagModel>[].obs;

  @override
  void onInit() async {
    super.onInit;
  }

  Future<List<TagModel>> getAllTags(String classId) async {
    try {
      // Fetch Tags
      final tags = await tagRepository.getAllTag(classId);
      return tags;
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<List<TagModel>> getSyllabusTags(String classId) async {
    try {
      // Fetch Tags
      final tags = await tagRepository.getAllTag(classId);
      return tags;
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void onSelectedTag(TagModel tag) {
    if (isSelectedTag(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  TagModel tagNode(String classId, List<TagModel> tags) {
    return tags.firstWhere((tag) => tag.id == classId,
        orElse: () => TagModel.empty());
  }

  TreeNode buildNode(TagModel tagNode, List<TagModel> tags) {
    return TreeNode(
        content: Expanded(
            child: Text(
          tagNode.tag!,
          maxLines: 2,
        )),
        children: tags
            .where((tag) => tag.parentId == tagNode.id)
            .map((tag) => buildNode(tag, tags))
            .toList());
  }

  bool isSelectedTag(TagModel tagCheck) {
    if (selectedTags.any((tag) => tag.id == tagCheck.id)) {
      return true;
    }
    return false;
  }

  Future addNewTag(String classId) async {
    try {
      if (tag.text.trim().isEmpty || tag.text.trim().trim().isEmpty) {
        LLoader.customToast(message: "Please enter the tag name!");
      } else {
        List<String> tags = [];
        tags.add(tag.text.trim());
        await tagRepository.addNewFreeTag(classId, tags);
        refreshData.toggle();

        LLoader.successSnackBar(
            title: "Add Tag Success",
            message: "Let's add some question with new tag");
        tag.clear();
      }
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  List<String> covertToListTag() {
    List<String> tags = [];
    tags.addAll(selectedTags.map((tag) => tag.id!).toList());
    return tags;
  }

  void removeTagFromSelected(TagModel tag) {
    selectedTags.remove(tag);
  }
}
