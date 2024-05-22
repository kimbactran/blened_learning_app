import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/data/repositories/authentication/authentication_repository.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/features/question/controllers/tag_controller.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/widgets/question_item.dart';
import 'package:blended_learning_appmb/features/question/screens/user/list_user_class.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';

class ClassDetailScreen extends StatelessWidget {
  const ClassDetailScreen({super.key, required this.course});

  final ClassModel course;

  @override
  Widget build(BuildContext context) {
    final tagController = TagController.instance;
    final authenticationRepository = AuthenticationRepository.instance;
    final user = authenticationRepository.user;
    return Scaffold(
      appBar: LAppBar(
        title: Text("Class Details",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
        actions: [
          if (user.role == 'TEACHER')
            PopupMenuButton<MenuClassOption>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {

                return <PopupMenuEntry<MenuClassOption>>[
                  const PopupMenuItem<MenuClassOption>(
                    value: MenuClassOption.manageUser,
                    child: Text('ManageUser'),
                  ),

                ];

              },
              onSelected: (MenuClassOption result) {
                if (result == MenuClassOption.manageUser) {
                  Get.to(() => ListUserClass(course: course,));
                }
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child:
        Column(
          children: [
             LQuestionItem(
              showBorder: true,
              course: course,
            ),
            FutureBuilder(
              future: tagController.getAllTags(course.id!),

              builder: (context, snapshot) {
                final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                if(widget != null) return widget;
                // Data found

                final tags = snapshot.data;
                final syllabusTags =  tags!.where((tag) => tag.type == "SYLLABUS").toList();
                final freeTags =  tags.where((tag) => tag.type == "FREE").toList();
                return Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(LSizes.sm),
                    child: LRoundedContainer(
                      showBorder: true,
                      child: TreeView(nodes: [
                        tagController.buildNode(tagController.tagNode(course.id!, syllabusTags), syllabusTags)
                      ]),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(LSizes.sm),
                    child: LRoundedContainer(
                      showBorder: true,
                      child: TreeView(nodes: [
                        TreeNode(
                          content: const Expanded(
                            child: Text("Free Tag"),
                          ),
                          children:
                                freeTags.map((tag) => TreeNode(content: Text(tag.tag!))).toList()
                        ),
                      ]),

                    ),
                  ),
                ],
              );}
            ),
          ],
        ),
      ),
    );
  }
}


