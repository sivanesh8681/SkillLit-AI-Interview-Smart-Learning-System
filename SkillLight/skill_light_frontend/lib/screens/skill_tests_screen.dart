import 'package:flutter/material.dart';

class SkillTestsScreen extends StatelessWidget {
  const SkillTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f8ff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff5f6dfb),
        leading: const BackButton(color: Colors.white),
        title: const Text("Skill Tests"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          const SizedBox(height: 20),

          Image.asset(
            "assets/images/skill_tests.png",
            height: 180,
          ),

          const SizedBox(height: 25),

          skillCard(
            title: "Java Programming",
            subtitle: "Coding",
            icon: Icons.code,
          ),

          skillCard(
            title: "Data Structures & Algorithms",
            subtitle: "Problem Solving",
            icon: Icons.lock_outline,
          ),
        ],
      ),
    );
  }

  Widget skillCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15)),
                const SizedBox(height: 5),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4f7cff),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {},
            child: const Text("Start"),
          )
        ],
      ),
    );
  }
}