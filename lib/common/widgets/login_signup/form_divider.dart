import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LFormDivider extends StatelessWidget {
  const LFormDivider({super.key, required this.dividerText});
  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = LHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? LColors.darkGrey : LColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? LColors.darkGrey : LColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        )
      ],
    );
  }
}
