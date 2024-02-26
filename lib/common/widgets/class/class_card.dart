import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/common/widgets/image/rounded_image.dart';
import 'package:blended_learning_appmb/features/question/screens/classes/classes_details.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LClassCard extends StatelessWidget {
  const LClassCard(
      {super.key,
      required this.showBorder,
      required this.classId,
      required this.className,
      required this.image});

  final bool showBorder;
  final String classId, className, image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const ClassDetailScreen()),
      child: Padding(
        padding: const EdgeInsets.all(LSizes.sm),
        child: LRoundedContainer(
          padding: const EdgeInsets.all(LSizes.sm),
          showBorder: showBorder,
          backgroundColor: Colors.transparent,
          child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    LRoundedImage(
                      imageUrl: LImages.classImage1,
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(
                      width: LSizes.spaceBtwItems,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MATH6464 - Xác suất thống kê'),
                        Text("Kỳ 2, Năm học 2023 - 2024")
                      ],
                    ),
                  ],
                ),
                LCircularContainer(
                  backgroundColor: LColors.secondary,
                  padding: LSizes.sm,
                  child: Text('2'),
                )
              ]),
        ),
      ),
    );
  }
}
