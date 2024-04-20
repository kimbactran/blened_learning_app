import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LDislikeButton extends StatelessWidget {
  const LDislikeButton({super.key,  this.onPressed, this.numDownVote = 0, required this.isDisLike});

  final bool isDisLike;
  final void Function()? onPressed;
  final int numDownVote;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Iconsax.dislike),
          onPressed: onPressed,

          color: isDisLike
              ? Colors.red
              : Colors.grey,
        ),
        Text(numDownVote.toString()),
      ],
    );
  }
}
