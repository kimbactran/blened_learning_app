import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/device/device_utility.dart';
import 'package:blended_learning_appmb/utils/helpers/helper_functions.dart';

import 'package:flutter/material.dart';

class EcoTabBar extends StatelessWidget implements PreferredSizeWidget {
  const EcoTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final darkMode = LHelperFunctions.isDarkMode(context);
    return Material(
      color: darkMode ? LColors.black : LColors.white,
      child: TabBar(
          isScrollable: true,
          indicatorColor: LColors.primary,
          unselectedLabelColor: LColors.darkGrey,
          labelColor: darkMode ? LColors.white : LColors.primary,
          tabs: tabs),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(LDeviceUtils.getAppBarHeight());
}
