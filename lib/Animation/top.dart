import 'package:flutter/material.dart';

class TopAnimation extends StatefulWidget {
  final Widget child;

  const TopAnimation({required this.child});

  @override
  _TopAnimationState createState() => _TopAnimationState();
}

class _TopAnimationState extends State<TopAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _TopAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _TopAnimation = Tween<Offset>(
      begin: const Offset(0.0, -9.0),
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
      position: _TopAnimation,
      child: widget.child,
    );
  }
}
