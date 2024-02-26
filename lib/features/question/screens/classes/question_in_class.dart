import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/question/question_card.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class QuestionInClassScreen extends StatelessWidget {
  const QuestionInClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppBar(
        title: Text("Question in Classes",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.sm),
          child: Column(
            children: [
              LQuestionCard(
                questionText:
                    "According to the table manners in England, we have to use a knife and folk at dinner",
                tags: ["UET", "Xác suất thống kê", "Biến cố của xác suất"],
              ),
              LQuestionCard(
                questionText:
                    "According to the table manners in England, we have to use a knife and folk at dinner",
                tags: ["UET", "Xác suất thống kê", "Biến cố của xác suất"],
              ),
              LQuestionCard(
                questionText:
                    "According to the table manners in England, we have to use a knife and folk at dinner",
                tags: ["UET", "Xác suất thống kê", "Biến cố của xác suất"],
              ),
              LQuestionCard(
                questionText:
                    "According to the table manners in England, we have to use a knife and folk at dinner",
                tags: ["UET", "Xác suất thống kê", "Biến cố của xác suất"],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
