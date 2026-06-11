import 'package:flutter/material.dart';
import 'analysis_screen.dart';

class CourseSelectionScreen extends StatelessWidget {
  final String program;
  CourseSelectionScreen({super.key, required this.program});

  final Map<String, List<String>> courseMap = {
    'BE': ['CSE', 'ECE', 'Mechanical', 'Civil', 'EEE', 'AI & DS'],
    'BTech': ['IT', 'AIML', 'Biotech', 'Chemical', 'Automobile'],
    'BSc': ['Agri', 'Biology', 'Computer Science', 'Chemistry', 'Physics', 'AI'],
    'MBA': ['Finance', 'Marketing', 'HR', 'Business Analytics'],
    'MBBS': ['General Medicine', 'Surgery', 'Pediatrics', 'Cardiology'],
    'BDS': ['Dental Surgery', 'Oral Pathology', 'Orthodontics'],
    'Nursing': ['General Nursing', 'Pediatric Nursing', 'Psychiatric Nursing'],
    'Pharmacy': ['B.Pharm', 'Pharm.D', 'Pharmaceutical Chemistry'],
  };

  @override
  Widget build(BuildContext context) {
    final courses = courseMap[program] ?? [];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('$program Courses'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            color: Colors.deepPurpleAccent.withOpacity(0.2),
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(course, style: const TextStyle(color: Colors.white, fontSize: 18)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AnalysisScreen(program: program, course: course))),
            ),
          );
        },
      ),
    );
  }
}
