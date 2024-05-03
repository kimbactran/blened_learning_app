import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/class/class_card.dart';
import 'package:blended_learning_appmb/common/widgets/icons/circular_icon.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/features/question/screens/tag/list_tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';

class TagOfUserScreen extends StatelessWidget {
  const TagOfUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final classController = ClassController.instance;


    return Scaffold(
      appBar: LAppBar(
        showBackArrow: true,
        title: Text('All Tag',
            style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          LCircularIcon(
            icon: Iconsax.notification,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: FutureBuilder(
            future: classController.getAllClasses(),
            builder: (context, snapshot) {
              final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
              if(widget != null) return widget;

              final courses = snapshot.data;
              return ListView.builder(itemCount: courses?.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return LClassCard(showBorder: true, course: courses![index],
                    onTap: () => Get.to(() => ListTag(classId: courses[index].id!)),);
                },);
              // Data found
            },
          ),
        )
      ),
    );
  }
}
