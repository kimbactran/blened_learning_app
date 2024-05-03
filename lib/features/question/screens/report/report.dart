import 'package:blended_learning_appmb/features/question/screens/report/report_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/class/class_card.dart';
import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/class_controller.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classController = ClassController.instance;

    return Scaffold(
      appBar: LAppBar(
        showBackArrow: true,
        title: Text('All Tag',
            style: Theme.of(context).textTheme.headlineSmall),

      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(LSizes.sm),
            child: FutureBuilder(
              future: classController.getAllClasses(),
              builder: (context, snapshot) {
                final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                if(widget != null) return widget;

                final courses = snapshot.data;
                return ListView.builder(itemCount: courses?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return LClassCard(showBorder: true, course: courses![index],
                      onTap: () => Get.to(() => ReportClassScreen(course: courses[index])),);
                  },);
                // Data found
              },
            ),
          )
      ),
    );
  }
}
