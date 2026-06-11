// lib/screens/program_selection_screen.dart
import 'package:flutter/material.dart';

class ProgramSelectionScreen extends StatelessWidget {
  const ProgramSelectionScreen({super.key});

  // 🧠 Global list of programs + subcourses (expanded)
  static final Map<String, List<String>> programs = {
    // 🎓 Student Category
    'B.Tech / BE': [
      'CSE',
      'ECE',
      'EEE',
      'MECH',
      'CIVIL',
      'AI & DS',
      'IT',
      'BIOTECH'
    ],
    'MBBS': [
      'Anatomy',
      'Physiology',
      'Biochemistry',
      'Pharmacology',
      'Pathology',
      'Microbiology',
      'Ophthalmology'
    ],
    'BDS': [
      'Oral Surgery',
      'Prosthodontics',
      'Periodontics',
      'Orthodontics'
    ],
    'MBA': [
      'Finance',
      'HR',
      'Marketing',
      'Operations',
      'IT Management'
    ],
    'B.Sc': ['Biology', 'Chemistry', 'Physics', 'Mathematics', 'Agriculture'],
    'School (Class)': [
      'Physics',
      'Chemistry',
      'Mathematics',
      'Biology',
      'Computer Science'
    ],

    // 💼 Job Seeker Category
    'Software Jobs': [
      'Flutter Developer',
      'Web Developer',
      'Data Analyst',
      'AI Engineer',
      'Cloud Engineer',
      'UI/UX Designer',
      'Backend Developer',
      'Full Stack Developer',
      'Mobile App Tester',
      'Cybersecurity Analyst'
    ],
    'Hardware / Core Jobs': [
      'Embedded Engineer',
      'Electrical Design Engineer',
      'Mechanical Design Engineer',
      'Civil Site Engineer',
      'Network Engineer',
      'Automation Engineer',
      'VLSI Design',
      'PLC Programmer'
    ],

    // 🧾 Competitive Exams (Example: India)
    'Competitive Exams - India': [
      'JEE Mains',
      'JEE Advanced',
      'NEET',
      'GATE',
      'UPSC',
      'TNPSC',
      'SSC',
      'Bank Exams',
      'Railway Exams',
      'CAT',
      'NET/JRF'
    ],

    // 🌎 You can later expand to more countries:
    // 'Competitive Exams - USA': ['SAT', 'GRE', 'GMAT', 'LSAT', 'MCAT'],
    // 'Competitive Exams - UK': ['UCAT', 'BMAT', 'A-levels'],
    // 'Competitive Exams - Canada': ['IELTS', 'CELPIP', 'MCAT-Canada'],

    // 🤖 AI Teaching Section
    'AI Teaching Programs': [
      'AI Tutor for Students',
      'Resume Analyzer',
      'Skill Enhancer',
      'AI Interview Coach',
      'Smart Exam Practice',
      'AI Question Solver',
      'AI Mock Interviewer'
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text('Select Your Program'),
        backgroundColor: Colors.deepPurple,
        elevation: 3,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const SizedBox(height: 6),
          const Text(
            'Pick your main programme or category',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // 🔹 Dynamic Program Cards
          ...programs.entries.map((entry) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: ExpansionTile(
                tilePadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  entry.key,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                children: entry.value.map((sub) {
                  return ListTile(
                    title: Text(
                      sub,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.deepPurple),
                    onTap: () {
                      // 👇 Navigate to Analysis Screen
                      Navigator.pushReplacementNamed(context, '/analysis');
                    },
                  );
                }).toList(),
              ),
            );
          }),

          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/analysis'),
            child: const Text(
              'Continue to Analysis',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
