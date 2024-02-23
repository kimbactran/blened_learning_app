import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/icons/circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppBar(
        title: Text('Q & A', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          LCircularIcon(
            icon: Iconsax.notification,
            onPressed: () {},
          ),
          LCircularIcon(
            icon: Iconsax.filter,
            onPressed: () {},
          ),
          LCircularIcon(
            icon: Iconsax.search_normal,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
