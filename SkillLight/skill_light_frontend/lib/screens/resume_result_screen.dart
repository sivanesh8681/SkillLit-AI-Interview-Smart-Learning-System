import 'package:flutter/material.dart';

class ResumeResultScreen extends StatelessWidget {
  final Map<String, dynamic> analysis;

  const ResumeResultScreen({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {

    final rating = (analysis["rating"] ?? 0).toDouble();
    final bestRoles = (analysis["best_roles"] ?? []) as List;
    final skills = (analysis["skills_to_improve"] ?? []) as List;
    final suggestions = (analysis["resume_suggestions"] ?? []) as List;
    final companies = (analysis["companies"] ?? []) as List;
    final salary = analysis["salary_range"] ?? "₹5L - ₹10L";
    return Scaffold(
      backgroundColor: Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF3F6FD8),
        title: Text("SkillLight"),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            Text(
              "Great Analysis of Your Resume!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            /// TOP GRID
            Row(
              children: [
                Expanded(child: ratingCard(rating)),
                SizedBox(width: 16),
                Expanded(child: bestMatchCard(bestRoles, salary)),
              ],
            ),

            SizedBox(height: 16),

            /// SECOND GRID
            Row(
              children: [
                Expanded(child: skillsCard(skills)),
                SizedBox(width: 16),
                Expanded(child: companiesCard(companies)),
              ],
            ),

            SizedBox(height: 16),

            /// RESUME SUGGESTIONS
            resumeSuggestionCard(suggestions),

            SizedBox(height: 16),

            /// DOWNLOAD CARD
            downloadCard(),

            SizedBox(height: 16),

            /// LEARNING SECTION
            learningCard(skills),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  // ---------------- RATING ----------------
  Widget ratingCard(double rating) {
    return card(
      Column(
        children: [
          SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: rating / 10,
                  strokeWidth: 10,
                ),
              ),
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: 12),
          Text("Your Resume Rating",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text("Explore suggestions to land better jobs"),
        ],
      ),
    );
  }

  // ---------------- BEST MATCH ----------------
  Widget bestMatchCard(List roles, String salary) {
    return card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Eligibility & Best Matches",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...roles.map((e)=> Text("✔ $e")),
          SizedBox(height: 10),
          Text("Estimated salary $salary",
              style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(double.infinity, 45),
            ),
            onPressed: (){},
            child: Text("Start AI Interview"),
          )
        ],
      ),
    );
  }
// ---------------- SKILLS ----------------
  Widget skillsCard(List skills) {
    return card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Skills To Improve For Top Roles",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...skills.map((e)=> Text("⭐ $e")),
          SizedBox(height: 10),
          gradientButton("Enhance Your Skills")
        ],
      ),
    );
  }

  // ---------------- COMPANIES ----------------
  Widget companiesCard(List companies) {
    return card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nearest Companies Hiring",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...companies.map((c)=> Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text("${c["name"]} - ${c["salary"] ?? ""}"),
          ))
        ],
      ),
    );
  }

  // ---------------- SUGGESTIONS ----------------
  Widget resumeSuggestionCard(List suggestions) {
    return card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Resume Improvement Suggestions",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...suggestions.map((e)=> Text("✔ $e")),
          SizedBox(height: 10),
          gradientButton("Enhance Your Skills")
        ],
      ),
    );
  }

  // ---------------- DOWNLOAD ----------------
  Widget downloadCard() {
    return card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Download Full Analysis",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          gradientButton("Download Results")
        ],
      ),
    );
  }

  // ---------------- LEARNING ----------------
  Widget learningCard(List skills) {
    return card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Start Learning & Level Up!",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: skills.map((e)=> Chip(label: Text(e))).toList(),
          ),
          SizedBox(height: 10),
          gradientButton("Start Learning!")
        ],
      ),
    );
  }
  // ---------------- COMMON ----------------
  Widget gradientButton(String text){
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3F6FD8), Color(0xFF5C8DF6)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget card(Widget child){
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10)
        ],
      ),
      child: child,
    );
  }
}