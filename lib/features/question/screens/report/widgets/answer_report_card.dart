import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AnswerReportCard extends StatelessWidget {
  const AnswerReportCard({super.key, required this.numOfQuestion, required this.numOfAnswer});

  final int numOfQuestion;
  final int numOfAnswer;

  @override
  Widget build(BuildContext context) {
    final String avg = (numOfAnswer / numOfQuestion).toStringAsFixed(2);

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
            const Icon(Iconsax.message_text),
            const SizedBox(height: LSizes.sm,),
            const Text('Total Answer'),
            const SizedBox(height: LSizes.sm,),
            Text('${numOfAnswer}',  style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: LSizes.sm,),
            Text('Average answer per question: ${avg}'),
          ],
        ),
      ),
    );
  }
}
