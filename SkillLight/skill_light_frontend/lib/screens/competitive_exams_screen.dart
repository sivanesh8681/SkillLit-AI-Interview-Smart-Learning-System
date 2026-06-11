import 'package:flutter/material.dart';
import '../data/syllabus_data.dart';
import 'syllabus_screen.dart';

class CompetitiveExamsScreen extends StatelessWidget {
  CompetitiveExamsScreen({super.key}); // ✅ removed const

  final List<Map<String, dynamic>> exams = [
    {"name": "UPSC", "icon": "assets/icons/upsc.jpg", "subjects": 10},
    {"name": "SSC", "icon": "assets/icons/ssc.jpg", "subjects": 6},
    {"name": "Banking Exams", "icon": "assets/icons/bankingexam.jpg", "subjects": 6},
    {"name": "Railways", "icon": "assets/icons/railways.jpg", "subjects": 5},
    {"name": "NEET", "icon": "assets/icons/neet.jpg", "subjects": 3},
    {"name": "JEE", "icon": "assets/icons/jee.jpg", "subjects": 3},
    {"name": "TET", "icon": "assets/icons/tet.jpg", "subjects": 5},
    {"name": "Police Exams", "icon": "assets/icons/policeexams.jpg", "subjects": 4},
    {"name": "CAT / MBA", "icon": "assets/icons/cat.jpg", "subjects": 4},
    {"name": "Army / Navy / Airforce", "icon": "assets/icons/defence.png", "subjects": 5},
    {"name": "RBI Grade B", "icon": "assets/icons/rbi.jpg", "subjects": 5},
    {"name": "State PSC", "icon": "assets/icons/state.jpg", "subjects": 6},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "Competitive Exams",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // 🔍 Search Box
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search exams...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 📌 Cards List
            Expanded(
              child: ListView.builder(
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  final exam = exams[index];

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SyllabusScreen(
                                examName: exam["name"],
                                examIcon: exam["icon"],
                                subjects:
                                SyllabusData.syllabus[exam["name"]] ?? {},
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 14),
                          height: 85,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                exam["icon"],
                                height: 45,
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Text(
                                  exam["name"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}