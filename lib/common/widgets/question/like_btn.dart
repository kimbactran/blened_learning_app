import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LLikeButton extends StatelessWidget {
  const LLikeButton({super.key, this.onPressed, this.numUpVote  = 0, required this.isLike});

  final bool isLike;
  final void Function()? onPressed;
  final int numUpVote;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Iconsax.like),
          onPressed: onPressed,

          color: isLike
              ? Colors.red
              : Colors.grey,
        ),
        Text(numUpVote.toString()),
      ],
    );
  }
}
