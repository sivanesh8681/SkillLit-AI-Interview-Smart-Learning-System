import 'package:flutter/material.dart';

class Interviewer {
  final String id;
  final String name;
  final String role;
  final String avatarUrl;
  final String description;

  Interviewer({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.description,
  });
}

class SelectInterviewerScreen extends StatelessWidget {
  SelectInterviewerScreen({super.key});

  final List<Interviewer> interviewers = [
    Interviewer(
      id: 'i1',
      name: 'Sam P.',
      role: 'HR Department',
      avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      description: 'Speaks politely and focuses on behavioral fit.',
    ),
    Interviewer(
      id: 'i2',
      name: 'Helen T.',
      role: 'Personal Interviewer',
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      description: 'Warm, coaching style — great for practice.',
    ),
    Interviewer(
      id: 'i3',
      name: 'Michael R.',
      role: 'Technical Interviewer',
      avatarUrl: 'https://randomuser.me/api/portraits/men/65.jpg',
      description: 'Tough but fair technical questioning.',
    ),
    Interviewer(
      id: 'i4',
      name: 'Emma K.',
      role: 'Customer Service',
      avatarUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
      description: 'Focus on communication & empathy.',
    ),
    Interviewer(
      id: 'i5',
      name: 'Brian L.',
      role: 'Leadership',
      avatarUrl: 'https://randomuser.me/api/portraits/men/12.jpg',
      description: 'Leadership & strategy focused.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String difficulty = args?["difficulty"] ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Interviewer"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: interviewers.length,
        itemBuilder: (context, index) {
          final it = interviewers[index];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/InterviewSetup',
                  arguments: {
                    "difficulty": difficulty,
                    "interviewer": it.name,
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        it.avatarUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(it.name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(it.role,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 13)),
                          const SizedBox(height: 6),
                          Text(it.description,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
