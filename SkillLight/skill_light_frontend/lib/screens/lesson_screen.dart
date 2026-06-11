import 'package:flutter/material.dart';
import '../data/lessons_data.dart';
import '../widgets/lesson_card.dart';
import 'classrooms_screen.dart';

// ✅ Dummy placeholder (backend controls real slides)
final Map<String, Map<String, Map<String, List>>> lessonSlidesData = {};

class LessonScreen extends StatelessWidget {
  final String exam;
  final String subject;

  const LessonScreen({
    super.key,
    required this.exam,
    required this.subject,
  });

  // ---------- EXAM KEY ----------
  String resolveExamKey(String exam) {
    final e = exam.toLowerCase();
    if (e.contains("ssc")) return "ssc";
    if (e.contains("bank")) return "banking";
    if (e.contains("upsc")) return "upsc";
    if (e.contains("neet")) return "neet";
    if (e.contains("jee")) return "jee";
    if (e.contains("cat")) return "cat";
    if (e.contains("army")) return "army";
    if (e.contains("rbi grade b")) return "rbi_grade_b";
    if (e.contains("state psc")) return "state_psc";
    if (e.contains("police")) return "police";
    return e;
  }

  // ---------- SUBJECT KEY ----------
  String resolveSubjectKey(String subject) {
    final s = subject.toLowerCase().trim();

    if (s.contains("logical reasoning") && s.contains("di")) {
      return "logical_reasoning_di";
    }
    if (s.contains("verbal ability")) return "verbal_ability";
    if (s.contains("business awareness")) return "business_awareness";
    if (s.contains("data interpretation")) return "data_interpretation";
    if (s.contains("quantitative")) return "quantitative_aptitude";
    if (s.contains("mathematics") || s == "maths" || s == "math") {
      return "mathematics";
    }
    if (s.contains("science (basic)") || s.contains("basic science")) {
      return "basic_science";
    }
    if (s.contains("logical reasoning")) return "logical_reasoning";
    if (s == "reasoning") return "reasoning";
    if (s.contains("english")) return "english";
    if (s.contains("general awareness")) return "general_awareness";
    if (s.contains("computer")) return "computer_knowledge";
    if (s.contains("banking awareness")) return "banking_awareness";
    if (s.contains("current affairs")) return "current_affairs";

    return s.replaceAll(RegExp(r'[^a-z0-9]+'), "_");
  }

  // ✅ ADD: difficulty resolver (USED in onTap)
  String resolveDifficulty(String subject, String title) {
    final t = title.toLowerCase();

    if (t.contains("math") ||
        t.contains("digital") ||
        t.contains("control") ||
        t.contains("signal")) {
      return "Hard";
    }

    if (t.contains("electronics") ||
        t.contains("physics") ||
        t.contains("computer")) {
      return "Medium";
    }

    return "Easy";
  }

  @override
  Widget build(BuildContext context) {
    final examKey = resolveExamKey(exam);
    final subjectKey = resolveSubjectKey(subject);

    final rawLessons = lessonsData[examKey]?[subjectKey];

    if (rawLessons == null) {
      return _noLessons();
    }

    final lessons = rawLessons
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    if (lessons.isEmpty) {
      return _noLessons();
    }

    return Scaffold(
      appBar: AppBar(title: Text(subject)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          final title = lesson["title"]?.toString() ?? "Untitled Lesson";
          final duration = lesson["duration"]?.toString() ?? "0h";

          return LessonCard(
            title: title,
            duration: duration,
            subject: subject,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ClassroomsScreen(
                    topic: title,
                    duration: duration,
                    difficulty: lesson["difficulty"]?.toString()
                        ?? resolveDifficulty(subject, title),
                    language: lesson["language"]?.toString() ?? "Tamil",
                    slides: const [], // backend will handle
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ✅ ADD: missing widget
  Widget _noLessons() {
    return Scaffold(
      appBar: AppBar(title: Text(subject)),
      body: const Center(
        child: Text(
          "No lessons available",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}