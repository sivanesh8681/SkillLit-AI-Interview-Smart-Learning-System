import 'package:flutter/material.dart';
import '../data/course_data.dart';
import '../models/course_item.dart';
import 'subject_list_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAF4FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Courses", style: TextStyle(color: Colors.black)),
        leading: const BackButton(color: Colors.black),
      ),

      body: Column(
        children: [

          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
            child: TextField(
              onChanged: (v) => setState(() => query = v.toLowerCase()),
              decoration: InputDecoration(
                hintText: "Search courses...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📜 LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: courseData.entries.map((section) {

                final filtered = section.value.where((c) =>
                    c.name.toLowerCase().contains(query)).toList();

                if (filtered.isEmpty) return const SizedBox();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // 🔵 SECTION TITLE
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 10, 6, 6),
                      child: Text(
                        section.key,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    ...filtered.map((course) => _courseCard(course)),

                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 🟦 COURSE TILE (same like image)
  Widget _courseCard(CourseItem course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SubjectListScreen(courseName: course.name),
            ),
          );
        },
        child: Container(
          height: 78,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Row(
            children: [

              // ICON
              Image.asset(
                "assets/icons/courses/${course.icon}",
                height: 42,
                width: 42,
                fit: BoxFit.contain,
              ),

              const SizedBox(width: 14),

              // TEXT
              Expanded(
                child: Text(
                  course.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }
}
