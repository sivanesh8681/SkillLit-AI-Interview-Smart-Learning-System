import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'classrooms_screen.dart';

class LessonPreviewScreen extends StatelessWidget {
  final String topic;
  final String duration;
  final String difficulty;

  const LessonPreviewScreen({
    super.key,
    required this.topic,
    required this.duration,
    required this.difficulty,
  });

  Future<void> startLesson(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/lesson/generate"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "topic": topic,
          "duration": duration,
          "difficulty": difficulty,
          "language": "tamil",
        }),
      ).timeout(const Duration(seconds: 60));

      if (context.mounted) Navigator.pop(context);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // ✅ FIXED: Safe data extraction
        String lessonTopic = data["topic"]?.toString() ?? topic;
        String lessonDuration = data["duration"]?.toString() ?? duration;
        String lessonDifficulty = data["difficulty"]?.toString() ?? difficulty;
        String lessonLanguage = data["language"]?.toString() ?? "Tamil";
        List slides = data["slides"] ?? [];

        if (slides.isEmpty) {
          throw Exception("No slides generated");
        }

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ClassroomsScreen(
                topic: lessonTopic,
                duration: lessonDuration,
                difficulty: lessonDifficulty,
                language: lessonLanguage,
                slides: slides,
              ),
            ),
          );
        }
      } else {
        throw Exception("API returned ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Error: $e");

      if (context.mounted) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString().substring(0, 50)}..."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 12,
              left: 12,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
              ),
            ),

            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 25,
                      offset: const Offset(0, 14),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        "assets/public/classroom.png",
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      topic.isNotEmpty
                          ? topic[0].toUpperCase() + topic.substring(1)
                          : topic,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "$duration • $difficulty",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 22),

                    GestureDetector(
                      onTap: () => startLesson(context),
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff8a9cff),
                              Color(0xffb07cff),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Start Lesson",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}