// lib/screens/feature_intro_screen.dart
import 'package:flutter/material.dart';

class FeatureIntroScreen extends StatelessWidget {
  const FeatureIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {'title': 'AI Resume Analyzer', 'icon': Icons.description},
      {'title': 'AI Human Interview', 'icon': Icons.record_voice_over},
      {'title': 'AI Teacher with Visuals', 'icon': Icons.school},
      {'title': 'Smart Learning Paths', 'icon': Icons.track_changes},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Feature Introduction'), backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          const SizedBox(height: 6),
          const Text('Your AI Features', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemBuilder: (c, i) {
                final f = features[i];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.deepPurple.shade100, child: Icon(f['icon'] as IconData, color: Colors.deepPurple)),
                    title: Text(f['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text('Tap continue to explore this feature'),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: features.length,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, padding: const EdgeInsets.symmetric(vertical: 14)),
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            child: const Text('Continue', style: TextStyle(color: Colors.white)),
          ),
        ]),
      ),
    );
  }
}