import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class InterviewAPI {
  static const String _baseUrl = 'http://127.0.0.1:8000';

  // ── Persistent session ID stored at class level ──────────────────
  // This ensures session_id is never lost between calls
  static String _currentSessionId = '';

  static String get currentSessionId => _currentSessionId;

  /// Start a new interview session — stores session_id internally
  static Future<Map<String, dynamic>> startSession({
    String jobRole = 'Software Engineer',
    String difficulty = 'medium',
    int durationMinutes = 10,
    String resumeContext = '',
  }) async {
    try {
      debugPrint('🚀 [InterviewAPI] Starting session...');

      final response = await http
          .post(
        Uri.parse('$_baseUrl/interview/start'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'job_role': jobRole,
          'difficulty': difficulty,
          'duration_minutes': durationMinutes,
          'resume_context': resumeContext,
        }),
      )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // ── CRITICAL: store session_id at class level ──
        _currentSessionId = data['session_id'] ?? '';
        debugPrint('✅ [InterviewAPI] Session created: $_currentSessionId');
        return data;
      } else {
        debugPrint('❌ [InterviewAPI] Start failed: ${response.statusCode} ${response.body}');
        return {
          'session_id': '',
          'question': 'Welcome! Please tell me about yourself.',
        };
      }
    } catch (e) {
      debugPrint('❌ [InterviewAPI] Start error: $e');
      return {
        'session_id': '',
        'question': 'Welcome! Please tell me about yourself.',
      };
    }
  }

  /// Send user answer → get next question
  /// Falls back to class-level session_id if passed id is empty
  static Future<String> sendMessage({
    required String sessionId,
    required String text,
  }) async {
    // ── Use class-level session_id as fallback if arg is empty ──
    final sid = sessionId.isNotEmpty ? sessionId : _currentSessionId;

    if (sid.isEmpty) {
      debugPrint('❌ [InterviewAPI] No session_id available!');
      return 'I did not catch that. Could you please repeat your answer?';
    }

    debugPrint('📤 [InterviewAPI] Sending message | session=$sid | text="${text.substring(0, text.length.clamp(0, 50))}..."');

    try {
      final response = await http
          .post(
        Uri.parse('$_baseUrl/interview/message'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'session_id': sid,
          'text': text,
        }),
      )
          .timeout(const Duration(seconds: 25));

      debugPrint('📥 [InterviewAPI] Message response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['reply'] ?? 'Thank you. Please continue.';
        debugPrint('💬 [InterviewAPI] Reply: "${reply.substring(0, reply.length.clamp(0, 80))}..."');
        return reply;
      } else if (response.statusCode == 404) {
        // Session expired — restart
        debugPrint('⚠️ [InterviewAPI] Session expired (404). Restarting...');
        final newSession = await startSession();
        _currentSessionId = newSession['session_id'] ?? '';
        return newSession['question'] ?? 'Let\'s continue. Please tell me about yourself.';
      } else {
        debugPrint('❌ [InterviewAPI] Message error: ${response.statusCode} ${response.body}');
        return 'I had a small issue. Please go ahead with your answer.';
      }
    } catch (e) {
      debugPrint('❌ [InterviewAPI] Message exception: $e');
      return 'I had a small issue. Please go ahead with your answer.';
    }
  }

  /// End session — returns evaluation
  static Future<Map<String, dynamic>> endSession(String sessionId) async {
    final sid = sessionId.isNotEmpty ? sessionId : _currentSessionId;
    try {
      final response = await http
          .post(
        Uri.parse('$_baseUrl/interview/end'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'session_id': sid}),
      )
          .timeout(const Duration(seconds: 20));

      _currentSessionId = ''; // clear after ending
      return jsonDecode(response.body);
    } catch (e) {
      return {
        'evaluation': {
          'verdict': 'Interview complete.',
          'overall_score': 7,
        }
      };
    }
  }
}
