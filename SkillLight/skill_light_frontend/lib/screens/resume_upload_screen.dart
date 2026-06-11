import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'resume_result_screen.dart';

class ResumeUploadScreen extends StatefulWidget {
  const ResumeUploadScreen({super.key});

  @override
  State<ResumeUploadScreen> createState() => _ResumeUploadScreenState();
}

class _ResumeUploadScreenState extends State<ResumeUploadScreen> {
  bool uploading = false;

  Future<void> pickResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'jpg', 'jpeg', 'png'],
      withData: true, // IMPORTANT for web
    );

    if (result == null) return;

    setState(() => uploading = true);

    try {
      final fileBytes = result.files.single.bytes!;
      final fileName = result.files.single.name;

      // ⚠ CHANGE IP if testing on phone/emulator
      final uri = Uri.parse("http://127.0.0.1:8000/resume/upload");

      final request = http.MultipartRequest('POST', uri);
      request.files.add(
        http.MultipartFile.fromBytes('file', fileBytes, filename: fileName),
      );

      final response = await request.send();
      final resStr = await response.stream.bytesToString();
      final data = jsonDecode(resStr);

      setState(() => uploading = false);

      // 👉 OPEN RESULT SCREEN WITH REAL DATA
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResumeResultScreen(
            analysis: data,
          ),
        ),
      );

    } catch (e) {
      setState(() => uploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F6FD8),
        centerTitle: true,
        title: const Text(
          "AI Resume Analyzer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),

      body: Column(
        children: [

          const SizedBox(height: 80),

          const Text(
            "Upload your Resume\n(PDF/DOCX)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          if (uploading) ...[
            const Text(
              "Upload in progress...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            const SizedBox(
              height: 90,
              width: 90,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation(Color(0xFF3F6FD8)),
              ),
            ),
          ],

          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: uploading ? null : pickResume,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F6FD8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Upload Resume",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}