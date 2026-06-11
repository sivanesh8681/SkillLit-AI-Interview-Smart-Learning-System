import 'package:flutter/material.dart';
import '../data/course_subjects_data.dart';

class SubjectListScreen extends StatefulWidget {
  final String courseName;

  const SubjectListScreen({super.key, required this.courseName});

  @override
  State<SubjectListScreen> createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  String query = "";

  // 🌈 Stunning gradient colors (auto rotate)
  final List<List<Color>> gradients = [
    [Color(0xff6a11cb), Color(0xff2575fc)],
    [Color(0xff11998e), Color(0xff38ef7d)],
    [Color(0xfffc4a1a), Color(0xfff7b733)],
    [Color(0xffee0979), Color(0xffff6a00)],
    [Color(0xff56ab2f), Color(0xffa8e063)],
    [Color(0xff614385), Color(0xff516395)],
    [Color(0xff02aab0), Color(0xff00cdac)],
    [Color(0xfff7971e), Color(0xffffd200)],
  ];

  @override
  Widget build(BuildContext context) {
    final subjects = courseSubjects[widget.courseName] ?? [];

    final filtered = subjects
        .where((s) => s["title"]!.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xffEEF6FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.courseName,
          style: const TextStyle(color: Colors.black),
        ),
        leading: const BackButton(color: Colors.black),
      ),

      body: Column(
        children: [

          // 🔍 SEARCH
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              onChanged: (v) => setState(() => query = v.toLowerCase()),
              decoration: InputDecoration(
                hintText: "Search subjects...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📚 SUBJECT LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final subject = filtered[index];
                final gradient = gradients[index % gradients.length];

                return _subjectCard(
                  title: subject["title"]!,
                  duration: subject["duration"]!,
                  gradient: gradient,
                  onTap: () {
                    // 👉 Next step: classroom
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🌟 GLOWING SUBJECT CARD
  Widget _subjectCard({
    required String title,
    required String duration,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: gradient.first.withOpacity(0.45),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Row(
            children: [

              // 🎯 ICON
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.play_circle_fill,
                    color: Colors.white, size: 30),
              ),

              const SizedBox(width: 14),

              // 📖 TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.arrow_forward_ios,
                  color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
