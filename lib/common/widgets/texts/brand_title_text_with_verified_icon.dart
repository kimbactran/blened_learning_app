import 'package:blended_learning_appmb/common/widgets/texts/brand_title_text.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/enums.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EcoBrandTitleWithVerifiedIcon extends StatelessWidget {
  const EcoBrandTitleWithVerifiedIcon(
      {super.key,
      required this.title,
      this.maxLines = 1,
      this.textColor,
      this.iconColor = LColors.primary,
      this.textAlign = TextAlign.center,
      this.brandTextSize = TextSizes.small});

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: LBrandTitleText(
          title: title,
          color: textColor,
          maxLines: maxLines,
          brandTextSize: brandTextSize,
        )),
        const SizedBox(
          width: LSizes.xs,
        ),
        const Icon(
          Iconsax.verify5,
          color: LColors.primary,
          size: LSizes.iconXs,
        )
      ],
    );
  }
}
