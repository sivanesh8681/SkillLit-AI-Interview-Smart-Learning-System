import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _fire = FirestoreService();
  final TextEditingController ageC = TextEditingController();
  String status = 'studying'; // or 'job'
  String course = '';
  String year = '';
  String jobType = 'software';
  bool saving = false;

  // example lists — extend per country logic
  final courses = ['B.Tech', 'B.Sc', 'B.Com', 'Diploma', '12th', '10th'];
  final years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  final jobTypes = ['software', 'hardware', 'civil', 'mechanical', 'others'];
  final exams = ['JEE', 'NEET', 'UPSC', 'Bank PO', 'State PSC'];

  Future<void> _saveProfile() async {
    final uid = ModalRoute.of(context)!.settings.arguments as String? ?? '';
    if (uid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Missing user id')));
      return;
    }
    setState(() => saving = true);
    await _fire.createUserProfile(uid, {
      'age': ageC.text,
      'status': status,
      'course': status == 'studying' ? course : null,
      'year': status == 'studying' ? year : null,
      'jobType': status == 'job' ? jobType : null,
      'preferredExam': status == 'studying' ? exams.first : null,
      'onboarded': true,
    });
    setState(() => saving = false);
    Navigator.pushReplacementNamed(context, '/home'); // implement home screen route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('One-time setup')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            const Text('Tell us a little about you', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(controller: ageC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Age')),
            const SizedBox(height: 12),
            const Text('I am a'),
            ListTile(
              title: const Text('Studying'),
              leading: Radio(value: 'studying', groupValue: status, onChanged: (v) => setState(() => status = v as String)),
            ),
            ListTile(
              title: const Text('Job searching'),
              leading: Radio(value: 'job', groupValue: status, onChanged: (v) => setState(() => status = v as String)),
            ),
            if (status == 'studying') ...[
              DropdownButtonFormField<String>(
                items: courses.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => course = v ?? ''),
                decoration: const InputDecoration(labelText: 'Select course'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                items: years.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                onChanged: (v) => setState(() => year = v ?? ''),
                decoration: const InputDecoration(labelText: 'Select year'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                items: exams.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) {}, // optional
                decoration: const InputDecoration(labelText: 'Exam preparing for'),
              ),
            ] else ...[
              DropdownButtonFormField<String>(
                items: jobTypes.map((j) => DropdownMenuItem(value: j, child: Text(j))).toList(),
                onChanged: (v) => setState(() => jobType = v ?? jobType),
                decoration: const InputDecoration(labelText: 'Preferred job domain'),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(onPressed: saving ? null : _saveProfile, child: saving ? const CircularProgressIndicator() : const Text('Save & Continue'))
          ],
        ),
      ),
    );
  }
}
