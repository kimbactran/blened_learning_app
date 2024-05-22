import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../features/question/models/user_attribute.dart';

class UserReportCard extends StatefulWidget {
  final UserAttributeModel userReport;

  const UserReportCard({super.key, required this.userReport});
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<UserReportCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(

        title: Text('Name: ${widget.userReport.user?.name }'),
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
        children: [
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(LSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${widget.userReport.user?.email }'),
                  const SizedBox(height: LSizes.spaceBtwItems,),
                  Text('Role: ${widget.userReport.user?.role }'),
                  const SizedBox(height: LSizes.spaceBtwItems,),
                  //const SizedBox(height: LSizes.spaceBtwItems,),
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Number Questions: ${widget.userReport.numQuestion }'),
                    ],
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems,),
                  Text('Number Answers: ${widget.userReport.numAnswer }'),
                  const SizedBox(height: LSizes.spaceBtwItems,),
                  Text('Number Like: ${widget.userReport.numLike }'),
                  const SizedBox(height: LSizes.spaceBtwItems,),
                  Text('Number Dislike: ${widget.userReport.numDislike }')
                ],
              ),
            ),
        ],
      ),
    );
  }
}