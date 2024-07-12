import 'package:flutter/material.dart';

class RightCAnimation extends StatefulWidget {
  final Widget child;

  const RightCAnimation({required this.child});

  @override
  _RightCAnimationState createState() => _RightCAnimationState();
}

class _RightCAnimationState extends State<RightCAnimation>
    with TickerProviderStateMixin {
  // Use TickerProviderStateMixin instead
  late AnimationController _animationControllerfirst;
  late Animation<Offset> _TopAnimationfirst;
  late AnimationController _animationController;
  late Animation<Offset> _circularAnimation;

  @override
  void initState() {
    super.initState();

    _animationControllerfirst = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _TopAnimationfirst = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationControllerfirst,
        curve: Curves.ease,
      ),
    );

    _animationControllerfirst.forward();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _circularAnimation = TweenSequence(
      <TweenSequenceItem<Offset>>[
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: Offset(0.0, -0.05),
            end: Offset(0.0, 0.0),
          ),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: Offset(0.0, 0.0),
            end: Offset(0.0, -0.05),
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

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationControllerfirst.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _circularAnimation,
      child: SlideTransition(
        position: _TopAnimationfirst,
        child: widget.child,
      ),
    );
  }
}
