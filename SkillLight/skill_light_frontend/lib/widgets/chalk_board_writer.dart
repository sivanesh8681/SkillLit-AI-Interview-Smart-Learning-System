import 'dart:async';
import 'package:flutter/material.dart';

class ChalkBoardWriter extends StatefulWidget {
  final List<String> lines;
  final double width;
  final double height;

  const ChalkBoardWriter({
    super.key,
    required this.lines,
    required this.width,
    required this.height,
  });

  @override
  State<ChalkBoardWriter> createState() => _ChalkBoardWriterState();
}

class _ChalkBoardWriterState extends State<ChalkBoardWriter> {
  final List<String> _written = [];
  int _lineIndex = 0;

  @override
  void initState() {
    super.initState();
    _startWriting();
  }

  void _startWriting() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_lineIndex < widget.lines.length) {
        setState(() {
          _written.add(widget.lines[_lineIndex]);
          _lineIndex++;
        });
      } else {
        timer.cancel();
        Future.delayed(const Duration(seconds: 2), _eraseBoard);
      }
    });
  }

  void _eraseBoard() {
    setState(() {
      _written.clear();
      _lineIndex = 0;
    });
    _startWriting();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: ChalkPainter(_written),
    );
  }
}

class ChalkPainter extends CustomPainter {
  final List<String> lines;

  ChalkPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontFamily: 'monospace',
    );

    double y = 10;

    for (final line in lines) {
      final textSpan = TextSpan(text: line, style: textStyle);
      final tp = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: size.width);
      tp.paint(canvas, Offset(10, y));
      y += 32;
    }
  }

  @override
  bool shouldRepaint(covariant ChalkPainter oldDelegate) => true;
}