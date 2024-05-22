import 'package:blended_learning_appmb/features/question/controllers/vote_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/question/models/question_model.dart';

class VoteQuestionWidget extends StatefulWidget {
  final QuestionModel question;
  const VoteQuestionWidget({super.key, required this.question});
  @override
  VoteWidgetState createState() => VoteWidgetState();
}

class VoteWidgetState extends State<VoteQuestionWidget>{
  bool _isLike = false;
  bool _isDislike = false;
  int _numUpVote = 0;
  int _numDownVote = 0;

  @override
  void initState() {
    super.initState();
    _isLike = widget.question.isUpVote!;
    _isDislike = widget.question.isDownVote!;
    _numDownVote =  widget.question.numDownVote!;
    _numUpVote =  widget.question.numUpVote!;
  }

  @override
  Widget build(BuildContext context) {
    final voteController = Get.put(VoteController());
    voteController.numUpVote.value = widget.question.numUpVote!;
    voteController.numDownVote.value = widget.question.numDownVote!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            flex: 1,
            child: Center(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Iconsax.like),
                    onPressed: () {
                      setState(() {
                        _isLike = !_isLike;

                        if(_isLike && _isDislike) {
                          _isDislike = !_isDislike;
                          if(_numDownVote >0) {
                            _numDownVote--;
                          }
                        }
                        if (_isLike) {
                          _numUpVote++;
                        } else {
                          if(_numUpVote > 0){
                            _numUpVote--;
                          }
                        }
                        voteController.likeQuestion(widget.question, _isLike);

                      });
                    },
                    color: _isLike ? Colors.red : Colors.grey,
                  ),
                  Text(_numUpVote.toString()),
                ],
              ),
            )
        ),

        Flexible(
            flex: 1,
            child: Center(
              child: Row(
              children: [
              IconButton(
              icon: const Icon(Iconsax.dislike),
    onPressed: () {
    setState(() {
    _isDislike = !_isDislike;
    if(_isLike && _isDislike) {
      _isLike = !_isLike;
      _numUpVote--;

    }
    if (_isDislike) {
    _numDownVote++;
    } else {
    if(_numDownVote > 0){
    _numDownVote--;
    }
    }
    voteController.dislikeQuestion(widget.question, _isDislike);
    });

    },
    color: _isDislike ? Colors.red : Colors.grey,
    ),
    Text(_numDownVote.toString()),
    ],
    )),
            )
      ],

    );
  }
}



