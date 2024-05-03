import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/models/tag_report_model.dart';
import 'package:blended_learning_appmb/features/question/models/user_attribute.dart';

class ReportModel {
  ClassModel? course;
  int? numQuestions;
  int? numAnswers;
  int? numLikes;
  int? numDislike;
  List<UserAttributeModel>? userAttributes;
  List<TagReportModel>? tagReports;

  ReportModel({
    this.course,
    this.numQuestions,
    this.numAnswers,
    this.numLikes,
    this.numDislike,
    this.userAttributes,
    this.tagReports
});

  static ReportModel empty() => ReportModel();
}