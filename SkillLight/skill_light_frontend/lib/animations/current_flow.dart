import 'package:flutter/material.dart';

class CurrentFlowAnimation extends StatefulWidget {
  const CurrentFlowAnimation({super.key});

  @override
  State<CurrentFlowAnimation> createState() => _CurrentFlowAnimationState();
}

class _CurrentFlowAnimationState extends State<CurrentFlowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return CustomPaint(
          size: const Size(200, 60),
          painter: _ArrowPainter(controller.value),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _ArrowPainter extends CustomPainter {
  final double t;
  _ArrowPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 4;

    final x = size.width * t;
    canvas.drawLine(Offset(x, 30), Offset(x + 20, 30), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
