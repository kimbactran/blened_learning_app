import 'package:blended_learning_appmb/common/widgets/image/rounded_image.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LVerticalImageText extends StatelessWidget {
  const LVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = LColors.black,
    this.backgroundColor,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: LSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular Icon
            LRoundedImage(
              imageUrl: image,
              width: 56,
              height: 56,
            ),
            // Container(
            //   width: 56,
            //   height: 56,
            //   padding: const EdgeInsets.all(LSizes.sm),
            //   decoration: BoxDecoration(
            //       color: backgroundColor ??
            //           (darkMode ? LColors.black : LColors.white),
            //       borderRadius: BorderRadius.circular(10)),
            //   child: Center(
            //     child: Image(
            //       image: AssetImage(image),
            //       fit: BoxFit.cover,
            //       color: darkMode ? LColors.light : LColors.dark,
            //     ),
            //   ),
            // ),

            /// Text
            const SizedBox(
              height: LSizes.spaceBtwItems / 2,
            ),
            Flexible(
              child: SizedBox(
                width: 62,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
