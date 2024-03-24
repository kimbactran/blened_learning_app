import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/class/class_card.dart';
import 'package:blended_learning_appmb/common/widgets/icons/circular_icon.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classController = ClassController.instance;

    return Scaffold(
      appBar: LAppBar(
        showBackArrow: true,
        title: Text('My Classes',
            style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          LCircularIcon(
            icon: Iconsax.notification,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            children: classController.allClasses
                .map((course) => LClassCard(showBorder: true, course: course))
                .toList()
            // [
            //   LClassCard(
            //     classId: "",
            //     showBorder: true,
            //     className: "",
            //     image: LImages.classImage,
            //   ),
            //   LClassCard(
            //     classId: "",
            //     showBorder: true,
            //     className: "",
            //     image: LImages.classImage,
            //   ),
            //   LClassCard(
            //     classId: "",
            //     showBorder: true,
            //     className: "",
            //     image: LImages.classImage,
            //   ),
            //   LClassCard(
            //     classId: "",
            //     showBorder: true,
            //     className: "",
            //     image: LImages.classImage,
            //   ),
            // ],
            ),
      ),
    );
  }
}
