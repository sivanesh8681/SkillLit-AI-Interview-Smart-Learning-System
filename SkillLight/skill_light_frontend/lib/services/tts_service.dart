import 'dart:async';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class TTSService {
  static final TTSService _instance = TTSService._internal();
  factory TTSService() => _instance;
  TTSService._internal();

  static const String _baseUrl = 'http://127.0.0.1:8000';

  html.AudioElement? _audio;

  /// Speak text using OpenAI TTS via backend, play in browser
  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;

    try {
      final response = await http
          .post(
        Uri.parse('$_baseUrl/interview/tts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text, 'voice': 'alloy'}),
      )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) return;

      final data = jsonDecode(response.body);
      final audioPath = data['audio_url']; // e.g. /audio/uuid.mp3
      if (audioPath == null) return;

      await stop(); // stop any existing audio first

      _audio = html.AudioElement('$_baseUrl$audioPath');
      _audio!.load();

      // ── FIX: use a guarded completer so complete() is only called ONCE ──
      final completer = Completer<void>();

      void safeComplete() {
        if (!completer.isCompleted) completer.complete();
      }

      _audio!.onEnded.listen((_) => safeComplete());
      _audio!.onError.listen((_) => safeComplete());

      // Safety timeout — if audio never fires onEnded, unblock after 3 min
      Future.delayed(const Duration(minutes: 3), safeComplete);

      await _audio!.play().catchError((_) => safeComplete());
      await completer.future;
    } catch (e) {
      debugPrint('TTS error: $e');
      // Fail silently — interview continues
    }
  }

  Future<void> stop() async {
    if (_audio != null) {
      try {
        _audio!.pause();
        _audio!.src = '';
      } catch (_) {}
      _audio = null;
    }
  }
}
