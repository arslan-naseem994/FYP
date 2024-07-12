import 'package:flutter/material.dart';

class RightAnimation extends StatefulWidget {
  final Widget child;

  const RightAnimation({required this.child});

  @override
  _RightAnimationState createState() => _RightAnimationState();
}

class _RightAnimationState extends State<RightAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _RightAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _RightAnimation = Tween<Offset>(
      begin: const Offset(9.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _RightAnimation,
      child: widget.child,
    );
  }
}
