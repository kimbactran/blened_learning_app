import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/class_model.dart';
import 'list_user.dart';

class ListUserClass extends StatelessWidget {
  const ListUserClass({super.key, required this.course});
  final ClassModel course;

  @override
  Widget build(BuildContext context) {
    final classController = ClassController.instance;
    return Scaffold(
      appBar: LAppBar(
        title: const Text('List User In Class'),
        showBackArrow: true,
        actions: [
          IconButton(
              onPressed: () => Get.to(() => ListUser(
                    course: course,
                  )),
              icon: const Icon(Iconsax.element_plus))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: Obx(
            () => FutureBuilder(
              key: Key(classController.refreshListUserData.value.toString()),
              future: classController.getUserOfClass(course.id!),
              builder: (context, snapshot) {
                final widget =
                    LCloudHelperFunctions.checkSingleRecordState(snapshot);
                if (widget != null) return widget;

                final users = snapshot.data;
                return ListView.builder(
                  itemCount: users?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: LUserCard(user: users![index])),
                        IconButton(
                          icon: const Icon(
                            Iconsax.minus,
                            color: LColors.primary1,
                          ),
                          onPressed: () => classController.removeUserFromClass(
                              users[index], course.id!),
                        )
                      ],
                    );
                  },
                );
                // Data found
              },
            ),
          ),
        ),
      ),
    );
  }
}
