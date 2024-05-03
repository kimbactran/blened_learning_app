import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuestionReportCard extends StatelessWidget {
  const QuestionReportCard({super.key, required this.numOfQuestion});

  final int numOfQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      padding: const EdgeInsets.all(LSizes.md),
      decoration: const BoxDecoration(
        color: LColors.primary1,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.message_question),
              const SizedBox(height: LSizes.sm,),
              const Text('Total Answer'),
              const SizedBox(height: LSizes.sm,),
              Text('${numOfQuestion}', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: LSizes.sm*4,),

            ],

        ),
      ),
    );
  }
}
