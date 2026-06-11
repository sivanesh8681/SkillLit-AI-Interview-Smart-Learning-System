// lib/screens/basic_details_screen.dart
import 'package:flutter/material.dart';

class BasicDetailsScreen extends StatefulWidget {
  const BasicDetailsScreen({super.key});
  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  final _ageController = TextEditingController();
  String _gender = 'male';
  String _status = 'student';
  @override
  Widget build(BuildContext context) {
    Widget statusCard(String id, IconData icon, String label) {
      bool selected = _status == id;
      return GestureDetector(
        onTap: () => setState(() => _status = id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            color: selected ? Colors.deepPurple.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: selected ? Colors.deepPurple : Colors.grey.shade300, width: selected ? 1.6 : 1),
            boxShadow: selected ? [BoxShadow(color: Colors.deepPurple.withOpacity(0.06), blurRadius: 12, offset: Offset(0,8))] : null,
          ),
          child: Column(children: [
            Icon(icon, size: 30, color: selected ? Colors.deepPurple : Colors.black54),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: selected ? Colors.deepPurple : Colors.black87)),
          ]),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tell us about yourself'), backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 6),
          const Text('We will personalize your experience based on your details', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 18),

          // Age + gender
          Row(children: [
            Expanded(
              child: TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter your age', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ),
            const SizedBox(width: 12),
            Column(children: [
              const Text('Gender'),
              const SizedBox(height: 6),
              Row(children: [
                ChoiceChip(label: const Text('Male'), selected: _gender == 'male', onSelected: (_) => setState(() => _gender = 'male')),
                const SizedBox(width: 8),
                ChoiceChip(label: const Text('Female'), selected: _gender == 'female', onSelected: (_) => setState(() => _gender = 'female')),
              ])
            ])
          ]),
          const SizedBox(height: 20),

          // Status cards
          const Text('Select your current status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: statusCard('student', Icons.school, 'Student')),
            const SizedBox(width: 10),
            Expanded(child: statusCard('job', Icons.work_outline, 'Job Seeker')),
            const SizedBox(width: 10),
            Expanded(child: statusCard('competitive', Icons.flag_outlined, 'Competitive')),
            const SizedBox(width: 10),
            Expanded(child: statusCard('ai_teach', Icons.school_outlined, 'AI Teaching')),
          ]),

          const Spacer(),

          // continue
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: () {
                // TODO: Save these details to Firebase or local store
                Navigator.pushReplacementNamed(context, '/program-selection');
              },
              child: const Text('Continue', style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }
}