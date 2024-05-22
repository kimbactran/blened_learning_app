import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LLikeButton extends StatefulWidget {
  const LLikeButton({Key? key, this.onPressed, this.numUpVote = 0, required this.isLike})
      : super(key: key);

  final bool isLike;
  final void Function()? onPressed;
  final int numUpVote;

  @override
  _LLikeButtonState createState() => _LLikeButtonState();
}

class _LLikeButtonState extends State<LLikeButton> {
  bool _isLike = false;
  int _numUpVote = 0;

  @override
  void initState() {
    super.initState();
    _isLike = widget.isLike;
    _numUpVote =  widget.numUpVote;
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
                _numUpVote++;
              } else {
                _numUpVote--;
              }
            });
            widget.onPressed?.call();
          },
          color: _isLike ? Colors.red : Colors.grey,
        ),
        Text(_numUpVote.toString()),
      ],
    );
  }
}