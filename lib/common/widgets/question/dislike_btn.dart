import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LDisLikeButton extends StatefulWidget {
  const LDisLikeButton({super.key, this.onPressed, this.numDownVote = 0, required this.isDislike});

  final bool isDislike;
  final void Function()? onPressed;
  final int numDownVote;

  @override
  _LDislikeButtonState createState() => _LDislikeButtonState();
}

class _LDislikeButtonState extends State<LDisLikeButton> {
  bool _isLike = false;
  int _numDownVote = 0;

  @override
  void initState() {
    super.initState();
    _isLike = widget.isDislike;
    _numDownVote =  widget.numDownVote;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Iconsax.like),
          onPressed: () {
            setState(() {
              _isLike = !_isLike;
              if (_isLike) {
                _numDownVote++;
              } else {
                _numDownVote--;
              }
            });
            widget.onPressed?.call();
          },
          color: _isLike ? Colors.red : Colors.grey,
        ),
        Text(_numDownVote.toString()),
      ],
    );
  }
}