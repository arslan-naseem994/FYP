import 'package:flutter/material.dart';

class LeftAnimation extends StatefulWidget {
  final Widget child;

  const LeftAnimation({required this.child});

  @override
  _LeftAnimationState createState() => _LeftAnimationState();
}

class _LeftAnimationState extends State<LeftAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _LeftAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _LeftAnimation = Tween<Offset>(
      begin: const Offset(-9.0, 0.0),
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
      position: _LeftAnimation,
      child: widget.child,
    );
  }
}
