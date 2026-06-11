import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  final List<String> guidelines = const [
    'Speak as if you are speaking to a real person.',
    'Remove background noise and distractions.',
    'Be concise and direct in your answers.',
    'Use STAR (Situation, Task, Action, Result) for behavioral answers.',
    'Do not share sensitive personal info (PII).',
    'Mention measurable results when possible.',
    'Pause briefly to think before answering.',
    'Speak politely and clearly.',
    'Ask for clarification if you are unsure.',
    'If any unwanted words in the outer Environment you will terminate .',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Interview Guidelines',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFEDE7F6),
                        child: Icon(Icons.menu_book, color: Colors.blue),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Before You Begin',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: guidelines.length,
                      separatorBuilder: (_, __) =>
                      const Divider(height: 10, color: Colors.grey),
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade50,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                        title: Text(
                          guidelines[index],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      label: const Text(
                        'Continue to Setup',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/interviewerLandscapeScreen');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
