import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/animation/like.dart';

class BigHeart extends StatefulWidget {
  final bool isLikeAnimating;
  final Function toggleLike;
  const BigHeart(
      {super.key, required this.isLikeAnimating, required this.toggleLike});

  @override
  State<BigHeart> createState() => _BigHeartState();
}

class _BigHeartState extends State<BigHeart> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: widget.isLikeAnimating ? 1 : 0,
      child: LikeAnimation(
        isAnimating: widget.isLikeAnimating,
        duration: const Duration(
          milliseconds: 400,
        ),
        onEnd: () {
          if (mounted) {
            setState(() {
              widget.toggleLike();
            });
          }
        },
        child: const Icon(
          Icons.favorite,
          color: Colors.white,
          size: 111,
        ),
      ),
    );
  }
}
