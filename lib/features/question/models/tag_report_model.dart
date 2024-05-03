import 'package:blended_learning_appmb/features/question/models/tag_model.dart';

class TagReportModel{
  TagModel? tag;
  int? numQuestion;
  int? numAnswer;
  int? numLike;
  int? numDislike;
  TagReportModel({
    this.tag,
    this.numQuestion,
    this.numAnswer,
    this.numLike,
    this.numDislike,
});
  static TagReportModel empty() => TagReportModel();
}