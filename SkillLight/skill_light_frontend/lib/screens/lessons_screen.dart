import 'package:flutter/material.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lessons"),
      ),
      body: const Center(
        child: Text(
          "Lesson Screen (AI Tutor)",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}