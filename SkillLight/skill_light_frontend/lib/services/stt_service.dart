// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;

class STTService {
  static final STTService _instance = STTService._internal();
  factory STTService() => _instance;
  STTService._internal();

  // ── Change to your backend IP ──────────────────────────────────────
  // Web runs at localhost so backend must also be localhost or CORS-enabled
  static const String _baseUrl = 'http://127.0.0.1:8000';

  html.MediaRecorder? _mediaRecorder;
  final List<html.Blob> _chunks = [];

  /// Start recording mic via browser
  Future<void> startRecording() async {
    _chunks.clear();
    try {
      final stream = await html.window.navigator.mediaDevices
          ?.getUserMedia({'audio': true, 'video': false});
      if (stream == null) return;

      _mediaRecorder = html.MediaRecorder(stream);
      _mediaRecorder!.addEventListener('dataavailable', (event) {
        final e = event as html.BlobEvent;
        if (e.data != null && e.data!.size > 0) _chunks.add(e.data!);
      });
      _mediaRecorder!.start();
    } catch (e) {
      // Mic denied — will return empty string from stopAndTranscribe
    }
  }

  /// Stop and send audio to OpenAI Whisper via backend
  Future<String> stopAndTranscribe() async {
    if (_mediaRecorder == null || _mediaRecorder!.state == 'inactive') {
      return '';
    }

    final completer = Completer<String>();

    _mediaRecorder!.addEventListener('stop', (_) async {
      try {
        if (_chunks.isEmpty) { completer.complete(''); return; }

        final blob = html.Blob(_chunks, 'audio/webm');
        if (blob.size < 2000) { completer.complete(''); return; } // silence

        // Read blob as bytes
        final reader = html.FileReader();
        reader.readAsArrayBuffer(blob);
        await reader.onLoad.first;
        final bytes = (reader.result as dynamic).cast<int>().toList();

        // POST to Whisper endpoint
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('$_baseUrl/interview/stt'),
        );
        request.files.add(http.MultipartFile.fromBytes(
          'file', bytes, filename: 'answer.webm',
        ));

        final response =
        await request.send().timeout(const Duration(seconds: 20));
        final body = await response.stream.bytesToString();
        final data = jsonDecode(body);
        completer.complete((data['text'] ?? '').toString().trim());
      } catch (e) {
        completer.complete('');
      }
    });

    _mediaRecorder!.stop();
    _mediaRecorder!.stream?.getTracks().forEach((t) => t.stop());

    return completer.future;
  }
}


