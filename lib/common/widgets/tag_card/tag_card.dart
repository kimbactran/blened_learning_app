import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/features/question/controllers/tag_controller.dart';
import 'package:blended_learning_appmb/features/question/models/tag_model.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LTagCard extends StatelessWidget {
  const LTagCard({
    super.key,
    required this.tag,
    this.color = LColors.secondary,
    this.onTap, this.showCancelBtn = false, this.onCancel, this.maxline = 2,
  });
  final TagModel tag;
  final Color color;
  final void Function()? onTap;
  final bool showCancelBtn;
  final void Function()? onCancel;
  final int maxline;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LRoundedContainer(
        backgroundColor: color,
        padding: const EdgeInsets.all(4),
        radius: LSizes.sm,
        margin: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                "# ${tag.tag}",
                maxLines: maxline,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if(showCancelBtn)
              Row(
                children: [
                  const SizedBox(width: LSizes.sm,),
                  IconButton(icon: const Icon(Iconsax.close_circle), onPressed: onCancel,)

                ],
              ),

          ],
        ),
      ),
    );
  }
}
