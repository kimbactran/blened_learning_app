import 'package:blended_learning_appmb/common/widgets/report_card/user_report_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/user_attribute.dart';

class UserAttributeTable extends StatelessWidget {
  const UserAttributeTable({super.key, required this.users});

  final List<UserAttributeModel> users;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text('User Attribute', style: Theme.of(context).textTheme.titleMedium),
        ResponsiveBuilder(builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
        return  SizedBox(
          width: LHelperFunctions.screenWidth() - 40,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
                columnSpacing: 12,
                horizontalMargin: 12,
                columns: const [
                  DataColumn(label: Expanded(child: Text('Name', maxLines: 2, overflow: TextOverflow.ellipsis,),)),
                  DataColumn(label: Expanded(child:Text('Email', maxLines: 2, overflow: TextOverflow.ellipsis,))),
                  DataColumn(label: Expanded(child:Text('Number Questions', maxLines: 2, overflow: TextOverflow.ellipsis,))),
                  DataColumn(label: Expanded(child:Text('Number Answer', maxLines: 2, overflow: TextOverflow.ellipsis,))),
                  DataColumn(label: Expanded(child:Text('Number Like', maxLines: 2, overflow: TextOverflow.ellipsis,))),
                  DataColumn(label: Expanded(child:Text('Number DisLike', maxLines: 2, overflow: TextOverflow.ellipsis,))),
                ], rows: users.map((user) =>  DataRow(cells: [
              DataCell(Text('${user.user?.name}')),
              DataCell(Text('${user.user?.email}')),
              DataCell(Text('${user.numQuestion}')),
              DataCell(Text('${user.numAnswer}')),
              DataCell(Text('${user.numLike}')),
              DataCell(Text('${user.numDislike}')),
            ])
            ).toList()),
          ),
        );
        }

        return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (_, index) {
        return UserReportCard(userReport: users[index]);
        }, itemCount: users.length,);
        },),

      ],
    );
  }
}
