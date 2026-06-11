// lib/screens/analysis_screen.dart
import 'package:flutter/material.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});
  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _anim;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _anim = CurvedAnimation(parent: _c, curve: Curves.easeInOut);
    _c.forward();
    // simulate backend analysis
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _done = true);
      }
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _progressView() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        width: 140,
        height: 140,
        child: AnimatedBuilder(
          animation: _anim,
          builder: (_, __) {
            return Transform.rotate(
              angle: _anim.value * 2.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade300]),
                ),
                child: Center(child: Icon(Icons.analytics, size: 56, color: Colors.white.withOpacity(0.95))),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 18),
      const Text('AI is analyzing your interests...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('Please wait a few seconds while we prepare your AI experience.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 22),
      SizedBox(width: 160, child: LinearProgressIndicator(value: _done ? 1 : null)),
    ]);
  }

  Widget _doneView() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.check_circle, size: 96, color: Colors.green),
      const SizedBox(height: 18),
      const Text('Analysis Completed', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
        onPressed: () => Navigator.pushReplacementNamed(context, '/feature-intro'),
        child: const Text('Go to Features' , style: TextStyle(color: Colors.white)),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analysis'), backgroundColor: Colors.deepPurple),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _done ? _doneView() : _progressView(),
        ),
      ),
    );
  }
}