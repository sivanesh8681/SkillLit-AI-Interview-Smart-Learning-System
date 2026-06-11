import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> startLessonAPI({
  required String topic,
  required String duration,
  required String difficulty,
}) async {

  // 🔴 CHANGE IP IF USING REAL MOBILE
  final url = Uri.parse("http://localhost:8000/lesson/start");

  final res = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "topic": topic,
      "duration": duration,
      "difficulty": difficulty,
    }),
  );

  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  } else {
    throw Exception("Lesson API Failed");
  }
}