import 'dart:async';
import 'package:flutter/material.dart';
import 'lesson_preview_screen.dart';

class LessonLoadingScreen extends StatefulWidget {
  final String topic;
  final String duration;
  final String difficulty;

  const LessonLoadingScreen({
    super.key,
    required this.topic,
    required this.duration,
    required this.difficulty,
  });

  @override
  State<LessonLoadingScreen> createState() => _LessonLoadingScreenState();
}

class _LessonLoadingScreenState extends State<LessonLoadingScreen> {
  @override
  void initState() {
    super.initState();

    // ⏳ Auto navigate to preview after 2.5 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LessonPreviewScreen(
            topic: widget.topic,
            duration: widget.duration,
            difficulty: widget.difficulty,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xfff3e9ff),
              Color(0xffd9e7ff),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Spacer(),

              const Text(
                "Preparing your\npersonalized classroom...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              const SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(
                    Color(0xff8a9cff),
                  ),
                ),
              ),

              const Spacer(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}