import 'package:flutter/material.dart';
import 'home_screen.dart';

class InterestSelectScreen extends StatefulWidget {
  final String category;
  const InterestSelectScreen({super.key, required this.category});

  @override
  State<InterestSelectScreen> createState() => _InterestSelectScreenState();
}

class _InterestSelectScreenState extends State<InterestSelectScreen> {
  String? _selectedInterest;

  List<String> _getInterests() {
    switch (widget.category) {
      case "Student":
        return [
          "College: B.Tech", "B.Sc", "B.Com", "BCA",
          "School: Physics", "Chemistry", "Biology", "Computer Science", "Social Science"
        ];
      case "Job Seeker":
        return [
          "IT Jobs", "Banking", "Engineering", "Healthcare", "Design", "Teaching", "Sales"
        ];
      case "Competitive":
        return [
          "UPSC", "TNPSC", "SSC", "Railway", "NEET", "JEE", "CRPF", "Airports Authority"
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final interests = _getInterests();

    return Scaffold(
      appBar: AppBar(title: const Text("Select Your Interest")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Choose one that fits you best",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: interests.map((interest) {
                  return RadioListTile<String>(
                    title: Text(interest),
                    value: interest,
                    groupValue: _selectedInterest,
                    onChanged: (v) => setState(() => _selectedInterest = v),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: _selectedInterest == null
                  ? null
                  : () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
