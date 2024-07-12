import 'package:flutter/material.dart';

class MultiAnimation extends StatefulWidget {
  final Widget child;

  const MultiAnimation({required this.child});

  @override
  _MultiAnimationState createState() => _MultiAnimationState();
}

class _MultiAnimationState extends State<MultiAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _circularAnimation;
  Offset? originalPosition;

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
            begin: Offset(0.0, -1.0), // Start point (top-center)
            end: Offset(1.0, 0.0), // Halfway point (right-center)
          ),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: Offset(1.0, 0.0), // Halfway point (right-center)
            end: Offset(0.0, 1.0), // Endpoint (bottom-center)
          ),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: Offset(0.0, 1.0), // Halfway point (right-center)
            end: Offset(0.0, 0.0), // Endpoint (bottom-center)
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

    // Store the original position before animation starts
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        originalPosition = _circularAnimation.value;
      }
    });

    _animationController.forward(); // Start the animation
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
