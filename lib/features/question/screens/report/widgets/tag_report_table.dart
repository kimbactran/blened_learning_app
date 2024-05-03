import 'package:blended_learning_appmb/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../models/tag_report_model.dart';

class TagReportTable extends StatelessWidget {
  const TagReportTable({super.key, required this.tagReports});

  final List<TagReportModel> tagReports;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Report by Tag'),

            SizedBox(

            width: LHelperFunctions.screenWidth() - 40,
               child: DataTable(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        columns: const [
                          DataColumn(label: Expanded(child: Text('Tag Name', maxLines: 2, overflow: TextOverflow.ellipsis,),)),
                          DataColumn(label: Expanded(child:Text('Number Questions', maxLines: 2, overflow: TextOverflow.ellipsis,))),
                          DataColumn(label: Expanded(child:Text('Number Answer', maxLines: 2, overflow: TextOverflow.ellipsis,))),
                          DataColumn(label: Expanded(child:Text('Number Like', maxLines: 2, overflow: TextOverflow.ellipsis,))),
                          DataColumn(label: Expanded(child:Text('Number DisLike', maxLines: 2, overflow: TextOverflow.ellipsis,))),
                    ], rows: tagReports.map((tagReport) =>  DataRow(cells: [
                      DataCell(Text('${tagReport.tag?.tag}')),
                      DataCell(Text('${tagReport.numQuestion}')),
                      DataCell(Text('${tagReport.numAnswer}')),
                      DataCell(Text('${tagReport.numLike}')),
                      DataCell(Text('${tagReport.numDislike}')),
                    ])
                    ).toList()),

           ),
      ],
    );
  }
}
