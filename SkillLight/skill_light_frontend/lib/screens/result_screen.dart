// interview_result_screen.dart

import 'package:flutter/material.dart';

class InterviewResultScreen extends StatelessWidget {
  const InterviewResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final score = args["score"] ?? 0;
    final strengths = args["strengths"] ?? [];
    final weaknesses = args["weaknesses"] ?? [];
    final summary = args["summary"] ?? "";

    return Scaffold(
      appBar: AppBar(title: Text("Interview Results")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              "Your Performance Score",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "$score / 100",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
            ),

            SizedBox(height: 25),

            Text("Strengths",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...strengths.map((s) => ListTile(
              leading: Icon(Icons.check, color: Colors.green),
              title: Text(s),
            )),

            SizedBox(height: 20),

            Text("Weaknesses",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...weaknesses.map((w) => ListTile(
              leading: Icon(Icons.close, color: Colors.red),
              title: Text(w),
            )),

            SizedBox(height: 20),

            Text("Overall Summary",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(summary, style: TextStyle(fontSize: 16)),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (r) => r.isFirst);
              },
              child: Text("Finish"),
            )
          ],
        ),
      ),
    );
  }
}
