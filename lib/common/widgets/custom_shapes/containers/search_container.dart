import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:blended_learning_appmb/utils/device/device_utility.dart';
import 'package:blended_learning_appmb/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LSearchContainer extends StatelessWidget {
  const LSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.padding = const EdgeInsets.symmetric(horizontal: LSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final darkMode = LHelperFunctions.isDarkMode(context);
    return Padding(
      padding: padding,
      child: Container(
        width: LDeviceUtils.getScreenWidth(),
        padding: const EdgeInsets.all(LSizes.md),
        decoration: BoxDecoration(
            color: showBackground
                ? darkMode
                    ? LColors.dark
                    : LColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(LSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: LColors.grey) : null),
        child: Row(
          children: [
            Icon(
              icon,
              color: LColors.darkGrey,
            ),
            const SizedBox(
              width: LSizes.spaceBtwItems,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
