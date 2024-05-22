import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/class_model.dart';

class ListUser extends StatelessWidget {
  const ListUser({super.key, required this.course});
  final ClassModel course;

  @override
  Widget build(BuildContext context) {
    final classController = ClassController.instance;
    return Scaffold(
      appBar: LAppBar(title: Text('List User'), showBackArrow: true,),
      body: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: Column(
            children: [
              Obx(
              () => FutureBuilder(
                key: Key(classController.refreshListUserData.value.toString()),
                future: classController.getUserEnable(course.id!),
                    builder: (context, snapshot) {
                      final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                      if(widget != null) return widget;

                      final users = snapshot.data;
                      return ListView.builder(itemCount: users?.length,
                        key: Key(classController.refreshListUserData.value.toString()),
                        shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            if(!classController.usersSelected.contains(users![index])) {
                              return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Expanded(child: LUserCard(user: users[index])),
                                IconButton(icon: const Icon(Iconsax.element_plus1, color: LColors.primary1,),
                                  onPressed: () => classController.addUserToClass(users[index], course.id!),)
                              ]
                            );
                            }
                          },
                      );
                      // Data found
                    },
                  ),
              ),

            ],
          ),

        ),
      ),);
  }
}
