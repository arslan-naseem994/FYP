import 'package:flutter/material.dart';

class MoveAnimation extends StatefulWidget {
  final Widget child;

  const MoveAnimation({required this.child});

  @override
  _MoveAnimationState createState() => _MoveAnimationState();
}

class _MoveAnimationState extends State<MoveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _circularAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _circularAnimation = TweenSequence(
      <TweenSequenceItem<Offset>>[
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: Offset(0.0, -0.07), // Start point (top-center)
            end: Offset(0.0, 0.0), // Halfway point (right-center)
          ),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: Offset(0.0, 0.0), // Halfway point (right-center)
            end: Offset(0.0, -0.07), // Endpoint (bottom-center)
          ),
          weight: 1.0,
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.repeat(reverse: true); // Repeat the circular animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _circularAnimation,
      child: widget.child,
    );
  }
}
