
import 'package:blended_learning_appmb/features/question/controllers/vote_controller.dart';
import 'package:blended_learning_appmb/features/question/models/answer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class VoteAnswerWidget extends StatefulWidget {
  final AnswerModel answer;

  const VoteAnswerWidget({super.key, required this.answer});

  @override
  VoteWidgetState createState() => VoteWidgetState();
}

class VoteWidgetState extends State<VoteAnswerWidget>{
  bool _isLike = false;
  bool _isDislike = false;
  int _numUpVote = 0;
  int _numDownVote = 0;

  @override
  void initState() {
    super.initState();
    _isLike = widget.answer.isUpVote!;
    _isDislike = widget.answer.isDownVote!;
    _numDownVote =  widget.answer.numDownVote!;
    _numUpVote =  widget.answer.numUpVote!;
  }

  @override
  Widget build(BuildContext context) {
    final voteController = Get.put(VoteController());
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
                      });
                      voteController.likeAnswer(widget.answer, _isLike);
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
                      if(_numUpVote > 0){
                        _numUpVote--;
                      }
                     }
                    if (_isDislike) {
                      _numDownVote++;
                      } else {
                        if(_numUpVote > 0){
                          _numDownVote--;
                        }
                      }
               });
              voteController.dislikeAnswer(widget.answer, _isDislike);
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



