import 'package:flutter/material.dart';

class HeartPumpingAnimation extends StatefulWidget {
  const HeartPumpingAnimation({super.key});

  @override
  State<HeartPumpingAnimation> createState() => _HeartPumpingAnimationState();
}

class _HeartPumpingAnimationState extends State<HeartPumpingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.9, end: 1.1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      ),
      child: const Icon(Icons.favorite, color: Colors.red, size: 80),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
