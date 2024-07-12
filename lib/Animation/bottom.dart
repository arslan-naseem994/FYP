import 'package:flutter/material.dart';

class BottomAnimation extends StatefulWidget {
  final Widget child;

  const BottomAnimation({required this.child});

  @override
  _BottomAnimationState createState() => _BottomAnimationState();
}

class _BottomAnimationState extends State<BottomAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _BottomAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _BottomAnimation = Tween<Offset>(
      begin: const Offset(0.0, 9.0),
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
      position: _BottomAnimation,
      child: widget.child,
    );
  }
}
