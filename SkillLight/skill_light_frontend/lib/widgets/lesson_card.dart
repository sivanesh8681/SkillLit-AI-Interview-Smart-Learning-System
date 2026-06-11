import 'package:flutter/material.dart';
import '../data/subject_colors.dart';

class LessonCard extends StatelessWidget {
  final String title;
  final String duration;
  final String subject;
  final VoidCallback onTap;

  const LessonCard({
    super.key,
    required this.title,
    required this.duration,
    required this.subject,
    required this.onTap,
  });

  // 🔑 normalize subject to match subjectGradients keys
  String _normalizeSubject(String subject) {
    final s = subject.toLowerCase();

    if (s.contains("physics")) return "Physics";
    if (s.contains("chemistry")) return "Chemistry";
    if (s.contains("biology")) return "Biology";
    if (s.contains("mathematics") || s.contains("maths")) return "Mathematics";
    if (s.contains("quantitative")) return "Quantitative Aptitude (Maths)";
    if (s.contains("reasoning")) return "Reasoning";
    if (s.contains("english")) return "English";
    if (s.contains("computer")) return "Computer Knowledge";
    if (s.contains("banking")) return "Banking Awareness";
    if (s.contains("current")) return "Current Affairs";
    if (s.contains("history")) return "History";
    if (s.contains("geography")) return "Geography";
    if (s.contains("polity")) return "Polity";
    if (s.contains("economy")) return "Economy";

    return "Default";
  }

  @override
  Widget build(BuildContext context) {
    final subjectKey = _normalizeSubject(subject);

    // ✅ SAFE gradient fetch
    final List<Color> gradient =
        subjectGradients[subjectKey] ??
            subjectGradients.values.first; // ultimate fallback

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    duration,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.play_circle_fill,
              color: Colors.white,
              size: 36,
            )
          ],
        ),
      ),
    );
  }
}