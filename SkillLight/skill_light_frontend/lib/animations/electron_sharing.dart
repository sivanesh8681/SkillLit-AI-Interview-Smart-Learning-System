import 'package:flutter/material.dart';
import 'dart:ui';

class ElectronSharingAnimation extends StatefulWidget {
  const ElectronSharingAnimation({super.key});

  @override
  State<ElectronSharingAnimation> createState() =>
      _ElectronSharingAnimationState();
}

class _ElectronSharingAnimationState extends State<ElectronSharingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ElectronPainter(controller),
      size: const Size(220, 140),
    );
  }
}

class _ElectronPainter extends CustomPainter {
  final Animation<double> animation;
  _ElectronPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final centerY = size.height / 2;

    // Atoms
    canvas.drawCircle(const Offset(50, 70), 24, paint);
    canvas.drawCircle(const Offset(170, 70), 24, paint);

    // Electron orbit
    final t = animation.value;
    final x = lerpDouble(50, 170, t)!;
    canvas.drawCircle(Offset(x, centerY), 6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
