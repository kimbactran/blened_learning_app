import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/common/widgets/image/rounded_image.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LClassCard extends StatelessWidget {
  const LClassCard(
      {super.key,
      required this.showBorder,
      this.image = LImages.classImage1,
      required this.course, this.onTap});

  final bool showBorder;
  final String? image;
  final ClassModel course;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(LSizes.sm),
        child: LRoundedContainer(
          padding: const EdgeInsets.all(LSizes.sm),
          showBorder: showBorder,
          backgroundColor: Colors.transparent,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              flex: 4,
              child: Row(
                children: [
                  LRoundedImage(
                    imageUrl: image!,
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(
                    width: LSizes.spaceBtwItems,
                  ),
                      Expanded(child: Text(course.title!, maxLines: 2, overflow: TextOverflow.ellipsis,)),
                    
                ],
              ),
            ),
            LCircularContainer(
              padding: LSizes.sm,
              child: Text(
                 '${course.numberQuestion ?? '0'}', style: Theme.of(context).textTheme.bodyLarge,),
            )
          ]),
        ),
      ),
    );
  }
}
