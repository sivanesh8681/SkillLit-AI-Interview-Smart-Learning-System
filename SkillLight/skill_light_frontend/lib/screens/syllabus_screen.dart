import 'package:flutter/material.dart';
import 'lesson_screen.dart';

class SyllabusScreen extends StatelessWidget {
  final String examName;
  final String examIcon;
  final Map<String, String> subjects;

  const SyllabusScreen({super.key, 
    required this.examName,
    required this.examIcon,
    required this.subjects,
  });

  // 🔑 ADD: Convert exam name → exam key
  String _examKeyFromName(String exam) {
    final e = exam.toLowerCase();

    if (e.contains("neet")) return "neet";
    if (e.contains("jee")) return "jee";
    if (e.contains("ssc")) return "ssc";
    if (e.contains("bank")) return "banking";
    if (e.contains("rail")) return "railways";
    if (e.contains("tet")) return "tet";
    if (e.contains("police")) return "police";
    if (e.contains("cat")) return "cat";
    if (e.contains("army") || e.contains("navy")) return "defence";
    if (e.contains("rbi")) return "rbi";
    if (e.contains("state")) return "state_psc";
    if (e.contains("upsc")) return "upsc";

    return exam; // fallback
  }

  // 🔑 ADD: Convert subject name → subject key
  String _subjectKeyFromName(String subject) {
    final s = subject.toLowerCase();

    if (s.contains("quantitative")) return "quantitative_aptitude";
    if (s.contains("reasoning")) return "reasoning";
    if (s.contains("english")) return "english";
    if (s.contains("general awareness")) return "general_awareness";
    if (s.contains("computer")) return "computer_knowledge";
    if (s.contains("banking awareness")) return "banking_awareness";
    if (s.contains("current affairs")) return "current_affairs";
    if (s.contains("physics")) return "physics";
    if (s.contains("chemistry")) return "chemistry";
    if (s.contains("biology")) return "biology";
    if (s.contains("history")) return "history";
    if (s.contains("geography")) return "geography";
    if (s.contains("polity")) return "polity";
    if (s.contains("economy")) return "economy";

    return subject; // fallback
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(examName, style: const TextStyle(color: Colors.black)),
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: subjects.entries.map((item) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonScreen(
                    exam: examName.toLowerCase(), // ✅ FIX
                    subject: item.key,            // ✅ FIX
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/syllabus/${item.value}",
                    height: 45,
                  ),
                  const SizedBox(width: 18),
                  Text(
                    item.key,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}