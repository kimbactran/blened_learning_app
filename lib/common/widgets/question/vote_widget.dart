import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'dislike_btn.dart';
import 'like_btn.dart';

class VoteWidget extends StatelessWidget {
  const VoteWidget({super.key, required this.isUpVote, required this.isDownVote, required this.numUpVote, required this.numDownVote,  this.isUpVoteAction,  this.isDownVoteAction});
  final bool isUpVote;
  final bool isDownVote;
  final int numUpVote;
  final int numDownVote;
  final void Function()? isUpVoteAction;
  final void Function()? isDownVoteAction;


  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              flex: 1,
              child: Center(
                child: LLikeButton(isLike: isUpVote,
                  numUpVote: numUpVote, onPressed: isUpVoteAction,),
              )
          ),

          Flexible(
              flex: 1,
              child: Center(
                child: LDislikeButton(isDisLike: isDownVote,
                  numDownVote: numDownVote, onPressed: isDownVoteAction,),
              )
          ),

        ],

    );
  }
}
