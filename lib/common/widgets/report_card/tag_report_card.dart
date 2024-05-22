import 'package:blended_learning_appmb/features/question/models/tag_report_model.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TagReportCard extends StatefulWidget {
  final TagReportModel tagReport;

  const TagReportCard({super.key, required this.tagReport});
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<TagReportCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(

        title: Text('Name: ${widget.tagReport.tag?.tag }'),
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
                  //const SizedBox(height: LSizes.spaceBtwItems,),
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Number Questions: ${widget.tagReport.numQuestion }'),
                    ],
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems,),
                  Text('Number Answers: ${widget.tagReport.numAnswer }'),
                  const SizedBox(height: LSizes.spaceBtwItems,),
                  Text('Number Like: ${widget.tagReport.numLike }'),
                  const SizedBox(height: LSizes.spaceBtwItems,),
                  Text('Number Dislike: ${widget.tagReport.numDislike }')
                ],
              ),
            ),
        ],
      ),
    );
  }
}