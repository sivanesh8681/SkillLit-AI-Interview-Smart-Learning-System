import 'dart:async';
import 'dart:math' show cos, sin, pi, sqrt;
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClassroomsScreen extends StatefulWidget {
  final String topic;
  final String duration;
  final String difficulty;
  final String language;
  final List slides;

  const ClassroomsScreen({
    super.key,
    required this.topic,
    required this.duration,
    required this.difficulty,
    required this.language,
    required this.slides,
  });

  @override
  State<ClassroomsScreen> createState() => _ClassroomsScreenState();
}

class _ClassroomsScreenState extends State<ClassroomsScreen>
    with TickerProviderStateMixin {
  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioRecorder recorder = AudioRecorder();

  // ✅ Lesson data
  Map<String, dynamic>? lessonData;
  bool isLessonLoading = true;

  // ✅ Current state
  int currentConceptIndex = 0;
  bool isTeachingConcept = true;
  int currentExampleIndex = 0;

  // ✅ Board state
  String boardHeading = "";
  List<String> boardLines = [];

  // ✅ Animation state
  String? activeRenderer;
  String? animationType;
  Map<String, dynamic>? animationData;
  bool isAnimationPlaying = false;

  // ✅ Voice synchronization
  bool isVoiceSpeaking = false;

  // ✅ Time tracking
  int elapsedSeconds = 0;
  Timer? lessonTimer;

  // ✅ Playback state
  bool paused = false;
  bool isPlayingAudio = false;
  bool isGeneratingAudio = false;
  bool hasStarted = false;
  bool isRecording = false;
  bool isProcessingQuestion = false;

  // ✅ Subject & language
  String subjectType = "mathematics";
  bool needsExamples = true;
  String currentLangCode = "en-IN";
  String currentVoiceName = "en-IN-Wavenet-D";
  String selectedLanguage = "English";

  // ✅ Animation controllers
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  late AnimationController avatarController;
  late Animation<double> avatarAnimation;

  final List<Map<String, String>> languages = [
    {"name": "English", "code": "en-IN"},
    {"name": "Tamil", "code": "ta-IN"},
    {"name": "Hindi", "code": "hi-IN"},
    {"name": "Telugu", "code": "te-IN"},
    {"name": "Malayalam", "code": "ml-IN"},
    {"name": "Kannada", "code": "kn-IN"},
    {"name": "Marathi", "code": "mr-IN"},
    {"name": "Bengali", "code": "bn-IN"},
    {"name": "Gujarati", "code": "gu-IN"},
  ];

  @override
  void initState() {
    super.initState();
    debugPrint("🎓 PREMIUM CLASSROOM ENGINE INIT");

    fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    );

    avatarController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    avatarAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(parent: avatarController, curve: Curves.easeInOut),
    );

    _setLanguage();
    _fetchDeepLesson();
  }

  void _setLanguage() {
    final langMap = {
      "tamil": "ta-IN",
      "hindi": "hi-IN",
      "english": "en-IN",
      "telugu": "te-IN",
      "malayalam": "ml-IN",
      "kannada": "kn-IN",
      "marathi": "mr-IN",
      "bengali": "bn-IN",
      "gujarati": "gu-IN",
    };

    currentLangCode = langMap[widget.language.toLowerCase()] ?? "en-IN";
    selectedLanguage = widget.language;
  }

  Future<void> _fetchDeepLesson() async {
    try {
      debugPrint("📡 Fetching lesson: ${widget.topic}");

      final dio = Dio();
      final response = await dio.post(
        "http://127.0.0.1:8000/lesson/generate-deep",
        data: {
          "topic": widget.topic,
          "duration": widget.duration,
          "difficulty": widget.difficulty,
          "language": widget.language,
        },
      );

      if (response.statusCode == 200 && response.data["concepts"] != null) {
        setState(() {
          lessonData = response.data;
          subjectType = response.data["subject"] ?? "mathematics";
          needsExamples = response.data["needs_examples"] ?? false;
          currentLangCode = response.data["language_code"] ?? "en-IN";
          currentVoiceName = response.data["voice_name"] ?? "en-IN-Wavenet-D";
          isLessonLoading = false;
        });
      } else {
        throw "Invalid response";
      }
    } catch (e) {
      debugPrint("❌ Lesson fetch error: $e");
      setState(() => isLessonLoading = false);
      _showError("Failed to load lesson. Please try again.");
    }
  }

  void startLesson() {
    setState(() => hasStarted = true);
    _startTimer();
    _playCurrentContent();
  }

  void _startTimer() {
    lessonTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!paused && mounted) setState(() => elapsedSeconds++);
    });
  }

  String get timeText {
    final m = elapsedSeconds ~/ 60;
    final s = elapsedSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Future<void> _playCurrentContent() async {
    if (!mounted || paused || lessonData == null) return;

    final concepts = lessonData!['concepts'] as List;

    if (currentConceptIndex >= concepts.length) {
      _showComplete();
      return;
    }

    final concept = concepts[currentConceptIndex];

    if (isTeachingConcept) {
      await _teachConcept(concept['teaching_content']);

      if (needsExamples && concept['examples'] != null) {
        final examples = concept['examples'] as List;
        if (examples.isNotEmpty) {
          setState(() {
            isTeachingConcept = false;
            currentExampleIndex = 0;
          });
          await Future.delayed(const Duration(seconds: 2));
          _playCurrentContent();
          return;
        }
      }

      _moveToNextConcept();
    } else {
      final examples = concept['examples'] as List;

      if (currentExampleIndex < examples.length) {
        await _teachExample(examples[currentExampleIndex]);

        setState(() => currentExampleIndex++);

        if (currentExampleIndex < examples.length) {
          await Future.delayed(const Duration(seconds: 2));
          _playCurrentContent();
        } else {
          _moveToNextConcept();
        }
      }
    }
  }

  void _moveToNextConcept() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted && !paused) {
      setState(() {
        currentConceptIndex++;
        isTeachingConcept = true;
        currentExampleIndex = 0;
      });
      _playCurrentContent();
    }
  }

  Future<void> _teachConcept(Map<String, dynamic> content) async {
    setState(() {
      boardHeading = content['heading'] ?? "";
      boardLines = List<String>.from(content['board_lines'] ?? []);

      if (content['animation'] != null) {
        final anim = content['animation'];
        activeRenderer = anim['renderer'];
        animationType = anim['type'];
        animationData = anim['data'] ?? {};
        isAnimationPlaying = true;
      } else {
        activeRenderer = null;
        isAnimationPlaying = false;
      }
    });

    fadeController.forward(from: 0);

    final speechText = content['speech_text'] ?? "";
    if (speechText.isNotEmpty) {
      setState(() => isVoiceSpeaking = true);
      await _speakText(speechText);
      setState(() => isVoiceSpeaking = false);
    }

    setState(() {
      activeRenderer = null;
      isAnimationPlaying = false;
    });
  }

  Future<void> _teachExample(Map<String, dynamic> example) async {
    setState(() {
      boardHeading = "Example";
      boardLines = [
        example['problem'] ?? "",
        ...List<String>.from(example['solution_steps'] ?? [])
      ];

      if (example['animation'] != null) {
        final anim = example['animation'];
        activeRenderer = anim['renderer'];
        animationType = anim['type'];
        animationData = anim['data'] ?? {};
        isAnimationPlaying = true;
      }
    });

    fadeController.forward(from: 0);

    final speechText = example['speech_text'] ?? "";
    if (speechText.isNotEmpty) {
      setState(() => isVoiceSpeaking = true);
      await _speakText(speechText);
      setState(() => isVoiceSpeaking = false);
    }

    setState(() {
      activeRenderer = null;
      isAnimationPlaying = false;
    });
  }

  Future<void> _speakText(String text) async {
    if (text.isEmpty) return;

    try {
      setState(() => isGeneratingAudio = true);

      final dio = Dio();
      final response = await dio.post(
        "http://127.0.0.1:8000/tts/google",
        data: {
          "text": text,
          "language": currentLangCode,
          "voice_name": currentVoiceName,
        },
      );

      setState(() => isGeneratingAudio = false);

      if (response.statusCode == 200 && response.data["success"] == true) {
        final url = "http://127.0.0.1:8000${response.data['audio_url']}";

        setState(() => isPlayingAudio = true);

        await audioPlayer.stop();
        await audioPlayer.play(UrlSource(url));

        final completer = Completer<void>();
        StreamSubscription<void>? subscription;
        subscription = audioPlayer.onPlayerComplete.listen((_) {
          subscription?.cancel();
          if (!completer.isCompleted) {
            completer.complete();
          }
        });

        await completer.future;
        setState(() => isPlayingAudio = false);
      }
    } catch (e) {
      debugPrint("❌ TTS error: $e");
      setState(() {
        isGeneratingAudio = false;
        isPlayingAudio = false;
      });
    }
  }

  void _togglePause() {
    setState(() => paused = !paused);
    if (paused) {
      audioPlayer.pause();
    } else {
      if (isPlayingAudio) {
        audioPlayer.resume();
      } else {
        _playCurrentContent();
      }
    }
  }

  void _nextContent() {
    audioPlayer.stop();

    if (isTeachingConcept) {
      if (needsExamples) {
        setState(() {
          isTeachingConcept = false;
          currentExampleIndex = 0;
        });
      } else {
        setState(() => currentConceptIndex++);
      }
    } else {
      setState(() {
        currentExampleIndex++;
        final concepts = lessonData!['concepts'] as List;
        final examples = concepts[currentConceptIndex]['examples'] as List?;

        if (examples == null || currentExampleIndex >= examples.length) {
          currentConceptIndex++;
          isTeachingConcept = true;
          currentExampleIndex = 0;
        }
      });
    }

    _playCurrentContent();
  }

  void _previousContent() {
    audioPlayer.stop();

    if (isTeachingConcept) {
      if (currentConceptIndex > 0) {
        setState(() => currentConceptIndex--);
      }
    } else {
      if (currentExampleIndex > 0) {
        setState(() => currentExampleIndex--);
      } else {
        setState(() => isTeachingConcept = true);
      }
    }

    _playCurrentContent();
  }

  Future<void> _handleMicPress() async {
    if (isRecording) {
      await _stopRecordingAndProcess();
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    try {
      await audioPlayer.pause();
      setState(() {
        paused = true;
        isRecording = true;
      });

      if (await recorder.hasPermission()) {
        await recorder.start(const RecordConfig(), path: 'question.m4a');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🎤 Ask your question...'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('❌ Recording error: $e');
      setState(() => isRecording = false);
    }
  }

  Future<void> _stopRecordingAndProcess() async {
    try {
      setState(() => isRecording = false);
      final path = await recorder.stop();

      if (path != null) {
        setState(() => isProcessingQuestion = true);

        final transcription = await _transcribeAudio(path);
        if (transcription != null && transcription.isNotEmpty) {
          final answer = await _getAIAnswer(transcription);
          if (answer != null && answer.isNotEmpty) {
            await _speakText(answer);
          }
        }

        setState(() => isProcessingQuestion = false);
        setState(() => paused = false);
        _playCurrentContent();
      }
    } catch (e) {
      debugPrint('❌ Processing error: $e');
      setState(() {
        isRecording = false;
        isProcessingQuestion = false;
        paused = false;
      });
    }
  }

  Future<String?> _transcribeAudio(String audioPath) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/stt'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', audioPath));
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);
        return data['text'];
      }
      return null;
    } catch (e) {
      debugPrint('❌ STT error: $e');
      return null;
    }
  }

  Future<String?> _getAIAnswer(String question) async {
    try {
      final context = """
Topic: ${widget.topic}
Current: $boardHeading
Content: ${boardLines.join(' ')}
Question: $question
""";

      final dio = Dio();
      final response = await dio.post(
        'http://127.0.0.1:8000/answer-question',
        data: {
          'question': question,
          'context': context,
          'language': selectedLanguage,
        },
      );

      if (response.statusCode == 200 && response.data['answer'] != null) {
        return response.data['answer'];
      }
      return null;
    } catch (e) {
      debugPrint('❌ AI answer error: $e');
      return null;
    }
  }

  void _showComplete() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.celebration, color: Colors.amber, size: 32),
            const SizedBox(width: 10),
            const Text("Lesson Complete!"),
          ],
        ),
        content: Text(
          'Completed: ${widget.topic}\n\n'
              'Time: $timeText\n'
              'Concepts: ${currentConceptIndex + 1}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Go Back"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    lessonTimer?.cancel();
    audioPlayer.dispose();
    recorder.dispose();
    fadeController.dispose();
    avatarController.dispose();
    super.dispose();
  }

  // =====================================================================
  // ✅ BUILD — UI ONLY CHANGED BELOW, ALL LOGIC ABOVE IS UNTOUCHED
  // =====================================================================

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ── Loading screen ──────────────────────────────────────────────────
    if (isLessonLoading) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/public/classroom.png', fit: BoxFit.cover),
            Container(color: Colors.black.withOpacity(0.55)),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 6,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Preparing your lesson...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Subject: $subjectType",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // ── Error screen ────────────────────────────────────────────────────
    if (lessonData == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 20),
              const Text("Failed to load lesson"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Go Back"),
              ),
            ],
          ),
        ),
      );
    }

    // ── Board dimensions ────────────────────────────────────────────────
    // Android landscape: screen is wider than tall, so we use landscape-aware values.
    // Teacher avatar occupies left ~28% of screen, board content must start after her hand.
    // Content starts at 30% left to avoid hand overlap, board background from 22%.
    final isLandscape = size.width > size.height;

    // Board background overlay position (matches chalkboard in PNG)
    final boardLeft   = size.width  * (isLandscape ? 0.225 : 0.22);
    final boardTop    = size.height * (isLandscape ? 0.09  : 0.10);
    final boardWidth  = size.width  * (isLandscape ? 0.740 : 0.760);
    final boardHeight = size.height * (isLandscape ? 0.56  : 0.53);

    // Content starts further right to clear teacher's raised hand
    final contentLeft  = size.width  * (isLandscape ? 0.315 : 0.30);
    final contentTop   = boardTop;
    final contentWidth = size.width  * (isLandscape ? 0.650 : 0.680);
    final contentHeight = boardHeight;

    // ── Main scaffold ───────────────────────────────────────────────────
    return Scaffold(
      body: Stack(
        children: [

          // ① BACKGROUND — classroom PNG fills entire screen
          Positioned.fill(
            child: Image.asset(
              'assets/public/classroom.png',
              fit: BoxFit.cover,
            ),
          ),

          // ② VERY SUBTLE darkening tint so text pops on the white wall
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.08)),
          ),

          // ③ BOARD CONTENT — overlaid on the chalkboard, shifted right to clear teacher hand
          Positioned(
            left:   contentLeft,
            top:    contentTop,
            width:  contentWidth,
            height: contentHeight,
            child: _buildBoardContent(contentWidth, contentHeight),
          ),

          // ④ TOP BAR — topic title + timer (aligned with board background, not content)
          Positioned(
            top: boardTop - 4,
            left: boardLeft + 8,
            width: boardWidth - 8,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(
                      widget.topic,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a472a).withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.greenAccent, width: 1.5),
                  ),
                  child: Text(
                    timeText,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ⑤ CONTROL BUTTONS — right side, vertically centered within board
          Positioned(
            right: 10,
            top: boardTop + boardHeight * 0.06,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _controlBtn(Icons.skip_previous, _previousContent, "Previous", Colors.orange),
                const SizedBox(height: 10),
                _controlBtn(
                  paused ? Icons.play_arrow : Icons.pause,
                  _togglePause,
                  paused ? "Resume" : "Pause",
                  paused ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 10),
                _controlBtn(Icons.skip_next, _nextContent, "Next", Colors.orange),
                const SizedBox(height: 16),
                _micBtn(
                  isRecording ? Icons.stop : Icons.mic,
                  _handleMicPress,
                  isRecording ? "Stop" : "Ask",
                  isRecording,
                ),
                const SizedBox(height: 10),
                _controlBtn(Icons.language, _showLanguageSelector, "Language", Colors.blue),
              ],
            ),
          ),

          // ⑥ BACK BUTTON
          Positioned(
            top: 14,
            left: 14,
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, size: 22, color: Colors.white),
              ),
              onPressed: () {
                audioPlayer.stop();
                Navigator.pop(context);
              },
            ),
          ),

          // ⑦ START BUTTON (shown before lesson begins)
          if (!hasStarted)
            Positioned(
              bottom: size.height * 0.08,
              left: contentLeft,
              right: size.width * 0.08,
              child: ElevatedButton.icon(
                onPressed: startLesson,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2e7d32),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 12,
                  shadowColor: Colors.green.withOpacity(0.6),
                ),
                icon: const Icon(Icons.play_arrow, size: 28, color: Colors.white),
                label: const Text(
                  "Start Lesson",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          // ⑧ STATUS BAR — bottom center aligned with content
          Positioned(
            bottom: isLandscape ? 10 : 14,
            left: contentLeft,
            right: size.width * 0.08,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: _getStatusColor().withOpacity(0.9),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: _getStatusColor().withOpacity(0.5),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isGeneratingAudio || isProcessingQuestion)
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  else
                    Icon(_getStatusIcon(), color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      _getStatusText(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Board content widget ─────────────────────────────────────────────
  Widget _buildBoardContent(double boardWidth, double boardHeight) {
    return Padding(
      // Inner padding: tight top, generous left for heading, zero background
      padding: EdgeInsets.fromLTRB(
        boardWidth * 0.02,   // left — small, content already shifted right
        boardHeight * 0.08,  // top
        boardWidth * 0.02,   // right
        boardHeight * 0.05,  // bottom
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── LEFT: Text section (48%) — narrower so animation has more room ──
          Expanded(
            flex: 48,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                FadeTransition(
                  opacity: fadeAnimation,
                  child: Text(
                    boardHeading,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Courier',
                      letterSpacing: 0.4,
                      shadows: [
                        Shadow(color: Colors.white38, blurRadius: 4),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 8),

                // Underline
                Container(
                  height: 2,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 12),

                // Board lines
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: boardLines.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: HandwrittenText(
                          text: boardLines[index],
                          delay: Duration(milliseconds: index * 600),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ── RIGHT: Animation section (52%) — transparent, sits on green board ──
          Expanded(
            flex: 52,
            child: Padding(
              // Extra left padding pushes animation away from text / teacher hand
              padding: EdgeInsets.only(left: boardWidth * 0.03),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: activeRenderer != null
                    ? RendererRouter(
                  renderer: activeRenderer!,
                  type: animationType ?? "general",
                  data: animationData ?? {},
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 48,
                        color: Colors.white.withOpacity(0.25),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers (unchanged) ──────────────────────────────────────────────

  Color _getStatusColor() {
    if (isRecording) return const Color(0xFFD32F2F);
    if (isProcessingQuestion) return const Color(0xFF1976D2);
    if (isGeneratingAudio) return const Color(0xFFF57C00);
    if (isPlayingAudio) return const Color(0xFF388E3C);
    if (isAnimationPlaying) return const Color(0xFF7B1FA2);
    return const Color(0xFF616161);
  }

  IconData _getStatusIcon() {
    if (isRecording) return Icons.mic;
    if (isProcessingQuestion) return Icons.psychology;
    if (isPlayingAudio) return Icons.volume_up;
    if (isAnimationPlaying) return Icons.animation;
    return Icons.school;
  }

  String _getStatusText() {
    if (isRecording) return "🎤 Listening...";
    if (isProcessingQuestion) return "🤖 Processing question...";
    if (isGeneratingAudio) return "Generating audio...";
    if (isPlayingAudio) {
      return isTeachingConcept
          ? "Teaching Concept ${currentConceptIndex + 1}"
          : "Solving Example ${currentExampleIndex + 1}";
    }
    if (isAnimationPlaying) return "Animation synchronized with voice...";
    if (hasStarted) {
      return "Concept ${currentConceptIndex + 1} • ${isTeachingConcept ? 'Teaching' : 'Examples'}";
    }
    return "Click 'Start Lesson' to begin";
  }

  void _showLanguageSelector() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Select Language"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final lang = languages[index];
                final isSelected = lang["name"] == selectedLanguage;

                return ListTile(
                  leading: Icon(
                    Icons.language,
                    color: isSelected ? Colors.green : Colors.grey,
                  ),
                  title: Text(
                    lang["name"]!,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.green : Colors.black,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedLanguage = lang["name"]!;
                      currentLangCode = lang["code"]!;
                    });
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _controlBtn(IconData icon, VoidCallback onTap, String tip, Color color) {
    return Tooltip(
      message: tip,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withOpacity(0.7)],
            ),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
      ),
    );
  }

  Widget _micBtn(IconData icon, VoidCallback onTap, String tip, bool isActive) {
    return Tooltip(
      message: tip,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isActive
                  ? [const Color(0xFFD32F2F), const Color(0xFFC62828)]
                  : [const Color(0xFF7B1FA2), const Color(0xFF6A1B9A)],
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? Colors.redAccent : Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isActive ? Colors.red : Colors.purple).withOpacity(0.6),
                blurRadius: isActive ? 18 : 10,
                spreadRadius: isActive ? 4 : 2,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}

// ✅ Handwritten text widget — UNCHANGED
class HandwrittenText extends StatefulWidget {
  final String text;
  final Duration delay;

  const HandwrittenText({
    super.key,
    required this.text,
    this.delay = Duration.zero,
  });

  @override
  State<HandwrittenText> createState() => _HandwrittenTextState();
}

class _HandwrittenTextState extends State<HandwrittenText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.text.length * 40),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _started = true);
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_started) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final displayLength = (_animation.value * widget.text.length).floor();
        final displayText = widget.text.substring(0, displayLength);

        return Text(
          displayText,
          style: TextStyle(
            fontSize: 20,
            height: 1.5,
            color: Colors.white,
            fontFamily: 'Courier',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.8,
            shadows: [
              Shadow(
                color: Colors.white.withOpacity(0.35),
                blurRadius: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ✅ RENDERER ROUTER — UNCHANGED
class RendererRouter extends StatelessWidget {
  final String renderer;
  final String type;
  final Map<String, dynamic> data;

  const RendererRouter({
    super.key,
    required this.renderer,
    required this.type,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    switch (renderer) {
      case "BiologyDiagramRenderer":
        return BiologyDiagramRenderer(type: type, data: data);
      case "MathEquationRenderer":
        return MathEquationRenderer(type: type, data: data);
      case "CircuitRenderer":
        return CircuitRenderer(type: type, data: data);
      case "GraphRenderer":
        return GraphRenderer(type: type, data: data);
      case "MoleculeRenderer":
        return MoleculeRenderer(type: type, data: data);
      case "FlowRenderer":
        return FlowRenderer(type: type, data: data);
      default:
        return DefaultRenderer(type: type);
    }
  }
}

// ========================================
// ALL RENDERER IMPLEMENTATIONS — UNCHANGED
// ========================================

class BiologyDiagramRenderer extends StatefulWidget {
  final String type;
  final Map<String, dynamic> data;
  const BiologyDiagramRenderer({super.key, required this.type, required this.data});
  @override
  State<BiologyDiagramRenderer> createState() => _BiologyDiagramRendererState();
}

class _BiologyDiagramRendererState extends State<BiologyDiagramRenderer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 4), vsync: this)..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() { controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    switch (widget.type.toLowerCase()) {
      case "cell_structure": return _CellStructure(animation: animation);
      case "organ_system": return _OrganSystem(animation: animation);
      case "body_system": return _BodySystem(animation: animation);
      default: return _CellStructure(animation: animation);
    }
  }
}

class _CellStructure extends StatelessWidget {
  final Animation<double> animation;
  const _CellStructure({required this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => CustomPaint(painter: _CellPainter(animation.value), child: Container()),
    );
  }
}

class _CellPainter extends CustomPainter {
  final double progress;
  _CellPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final membranePaint = Paint()
      ..color = const Color(0xFF4CAF50).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawOval(Rect.fromCenter(center: center, width: size.width * 0.85, height: size.height * 0.75), membranePaint);

    if (progress > 0.2) {
      final nucleusSize = 60 * ((progress - 0.2) / 0.8);
      canvas.drawCircle(center, nucleusSize, Paint()..color = const Color(0xFF9C27B0).withOpacity(0.7));
      if (progress > 0.4) canvas.drawCircle(center, nucleusSize * 0.4, Paint()..color = const Color(0xFF6A1B9A));
    }

    if (progress > 0.5) {
      for (final pos in [Offset(center.dx - 80, center.dy - 50), Offset(center.dx + 70, center.dy + 40)]) {
        canvas.drawOval(Rect.fromCenter(center: pos, width: 50, height: 25), Paint()..color = const Color(0xFFF44336).withOpacity(0.7));
        canvas.drawOval(Rect.fromCenter(center: pos, width: 40, height: 20), Paint()..color = const Color(0xFFD32F2F)..style = PaintingStyle.stroke..strokeWidth = 2);
      }
    }

    if (progress > 0.7) {
      final ribosomePaint = Paint()..color = const Color(0xFFFFEB3B);
      for (int i = 0; i < 12; i++) {
        final angle = (i * 30 + progress * 360) * pi / 180;
        canvas.drawCircle(Offset(center.dx + 90 * cos(angle), center.dy + 90 * sin(angle)), 3, ribosomePaint);
      }
    }

    if (progress > 0.9) {
      final tp = TextPainter(textDirection: TextDirection.ltr);
      for (final label in [
        {"text": "Nucleus", "pos": Offset(center.dx + 10, center.dy + 70)},
        {"text": "Mitochondria", "pos": Offset(center.dx - 100, center.dy - 70)},
        {"text": "Cell Membrane", "pos": Offset(center.dx - 120, center.dy)},
      ]) {
        tp.text = TextSpan(text: label["text"] as String, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold));
        tp.layout();
        tp.paint(canvas, label["pos"] as Offset);
      }
    }
  }

  @override
  bool shouldRepaint(_CellPainter oldDelegate) => true;
}

class _OrganSystem extends StatelessWidget {
  final Animation<double> animation;
  const _OrganSystem({required this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => CustomPaint(painter: _OrganPainter(animation.value), child: Container()),
    );
  }
}

class _OrganPainter extends CustomPainter {
  final double progress;
  _OrganPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final heartPath = Path();
    heartPath.moveTo(center.dx, center.dy + 40);
    heartPath.cubicTo(center.dx - 50, center.dy - 20, center.dx - 50, center.dy - 60, center.dx, center.dy - 40);
    heartPath.cubicTo(center.dx + 50, center.dy - 60, center.dx + 50, center.dy - 20, center.dx, center.dy + 40);
    canvas.drawPath(heartPath, Paint()..color = const Color(0xFFE91E63).withOpacity(0.3 + progress * 0.3));

    for (int i = 0; i < 8; i++) {
      final angle = ((progress + i * 0.125) % 1.0) * 2 * pi;
      canvas.drawCircle(Offset(center.dx + 70 * cos(angle), center.dy + 70 * sin(angle)), 5, Paint()..color = const Color(0xFFE53935));
    }
  }

  @override
  bool shouldRepaint(_OrganPainter old) => true;
}

class _BodySystem extends StatelessWidget {
  final Animation<double> animation;
  const _BodySystem({required this.animation});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.accessibility_new, size: 120, color: Colors.blue.withOpacity(0.3 + animation.value * 0.4)),
        const SizedBox(height: 20),
        const Text("Human Body System", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold)),
      ]),
    );
  }
}

class MathEquationRenderer extends StatefulWidget {
  final String type;
  final Map<String, dynamic> data;
  const MathEquationRenderer({super.key, required this.type, required this.data});
  @override
  State<MathEquationRenderer> createState() => _MathEquationRendererState();
}

class _MathEquationRendererState extends State<MathEquationRenderer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 5), vsync: this)..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
  }
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => _EquationSolving(animation: animation);
}

class _EquationSolving extends StatelessWidget {
  final Animation<double> animation;
  const _EquationSolving({required this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final step = (animation.value * 4).floor();
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildStep(0, step, "2x² + 3x + 1 = 0"),
          const SizedBox(height: 12),
          if (step >= 1) _buildStep(1, step, "a=2, b=3, c=1"),
          const SizedBox(height: 12),
          if (step >= 2) _buildStep(2, step, "D = b² - 4ac"),
          const SizedBox(height: 12),
          if (step >= 3) _buildStep(3, step, "D = 9 - 8 = 1"),
          const SizedBox(height: 12),
          if (step >= 4) _buildStep(4, step, "x = (-3 ± √1) / 4"),
        ]);
      },
    );
  }

  Widget _buildStep(int stepNum, int currentStep, String text) {
    final isActive = stepNum == currentStep;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue.withOpacity(0.3) : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isActive ? Colors.blueAccent : Colors.white30, width: isActive ? 2 : 1),
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: isActive ? 17 : 15, fontWeight: isActive ? FontWeight.bold : FontWeight.normal, fontFamily: 'Courier')),
    );
  }
}

class CircuitRenderer extends StatefulWidget {
  final String type;
  final Map<String, dynamic> data;
  const CircuitRenderer({super.key, required this.type, required this.data});
  @override
  State<CircuitRenderer> createState() => _CircuitRendererState();
}

class _CircuitRendererState extends State<CircuitRenderer> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 3), vsync: this)..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
  }
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => CustomPaint(painter: _CircuitPainter(animation.value), child: Container()),
    );
  }
}

class _CircuitPainter extends CustomPainter {
  final double progress;
  _CircuitPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white..strokeWidth = 3..style = PaintingStyle.stroke;
    final rect = Rect.fromLTWH(size.width * 0.1, size.height * 0.2, size.width * 0.8, size.height * 0.6);
    canvas.drawRect(rect, paint);

    final batteryX = rect.left;
    final batteryY = rect.center.dy;
    canvas.drawLine(Offset(batteryX - 10, batteryY), Offset(batteryX + 10, batteryY), Paint()..color = Colors.red..strokeWidth = 6);
    canvas.drawLine(Offset(batteryX - 5, batteryY - 10), Offset(batteryX - 5, batteryY + 10), Paint()..color = Colors.red..strokeWidth = 3);

    final resistorX = rect.center.dx;
    final resistorY = rect.top;
    final zigzag = Path();
    zigzag.moveTo(resistorX - 20, resistorY);
    for (int i = 0; i < 4; i++) {
      zigzag.lineTo(resistorX - 15 + i * 10, resistorY + (i % 2 == 0 ? -10 : 10));
    }
    zigzag.lineTo(resistorX + 20, resistorY);
    canvas.drawPath(zigzag, Paint()..color = Colors.orange..strokeWidth = 3);

    for (int i = 0; i < 6; i++) {
      final ep = (progress + i / 6) % 1.0;
      Offset pos;
      if (ep < 0.25) {
        pos = Offset(rect.right, rect.bottom - (ep / 0.25) * rect.height);
      } else if (ep < 0.5) pos = Offset(rect.right - ((ep - 0.25) / 0.25) * rect.width, rect.top);
      else if (ep < 0.75) pos = Offset(rect.left, rect.top + ((ep - 0.5) / 0.25) * rect.height);
      else pos = Offset(rect.left + ((ep - 0.75) / 0.25) * rect.width, rect.bottom);
      canvas.drawCircle(pos, 4, Paint()..color = Colors.yellow);
    }
  }

  @override
  bool shouldRepaint(_CircuitPainter old) => true;
}

class GraphRenderer extends StatefulWidget {
  final String type;
  final Map<String, dynamic> data;
  const GraphRenderer({super.key, required this.type, required this.data});
  @override
  State<GraphRenderer> createState() => _GraphRendererState();
}

class _GraphRendererState extends State<GraphRenderer> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 4), vsync: this)..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
  }
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    switch (widget.type.toLowerCase()) {
      case "derivative_tangent": return _DerivativeTangent(animation: animation);
      case "complex_plane": return _ComplexPlane(animation: animation);
      case "wave_animation": return _WaveGraph(animation: animation);
      default: return _FunctionPlot(animation: animation);
    }
  }
}

class _FunctionPlot extends StatelessWidget {
  final Animation<double> animation;
  const _FunctionPlot({required this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => CustomPaint(painter: _FunctionPlotPainter(animation.value), child: Container()),
    );
  }
}

class _FunctionPlotPainter extends CustomPainter {
  final double progress;
  _FunctionPlotPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()..color = Colors.white70..strokeWidth = 2;
    canvas.drawLine(Offset(size.width * 0.1, size.height * 0.9), Offset(size.width * 0.9, size.height * 0.9), axisPaint);
    canvas.drawLine(Offset(size.width * 0.1, size.height * 0.1), Offset(size.width * 0.1, size.height * 0.9), axisPaint);

    final path = Path();
    bool first = true;
    for (double x = 0; x <= progress; x += 0.01) {
      final px = size.width * 0.1 + x * size.width * 0.8;
      final py = size.height * 0.9 - x * x * size.height * 0.7;
      if (first) { path.moveTo(px, py); first = false; } else { path.lineTo(px, py); }
    }
    canvas.drawPath(path, Paint()..color = Colors.cyan..strokeWidth = 3..style = PaintingStyle.stroke);

    if (progress > 0) {
      final px = size.width * 0.1 + progress * size.width * 0.8;
      final py = size.height * 0.9 - progress * progress * size.height * 0.7;
      canvas.drawCircle(Offset(px, py), 6, Paint()..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(_FunctionPlotPainter old) => true;
}

class _DerivativeTangent extends StatelessWidget {
  final Animation<double> animation;
  const _DerivativeTangent({required this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => CustomPaint(painter: _DerivativePainter(animation.value), child: Container()),
    );
  }
}

class _DerivativePainter extends CustomPainter {
  final double progress;
  _DerivativePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (double x = 0; x <= 1; x += 0.01) {
      final px = x * size.width;
      final py = size.height - x * x * size.height * 0.9;
      if (x == 0) {
        path.moveTo(px, py);
      } else {
        path.lineTo(px, py);
      }
    }
    canvas.drawPath(path, Paint()..color = Colors.blue..strokeWidth = 3..style = PaintingStyle.stroke);

    final pointX = progress * 0.8 + 0.1;
    final px = pointX * size.width;
    final py = size.height - pointX * pointX * size.height * 0.9;
    final slope = 2 * pointX;

    canvas.drawCircle(Offset(px, py), 8, Paint()..color = Colors.red);

    final tangentPath = Path();
    final tl = size.width * 0.2;
    tangentPath.moveTo(px - tl, py - slope * tl * size.height * 0.9);
    tangentPath.lineTo(px + tl, py + slope * tl * size.height * 0.9);
    canvas.drawPath(tangentPath, Paint()..color = Colors.orange..strokeWidth = 2);

    final tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = TextSpan(text: "f'(x) = ${slope.toStringAsFixed(2)}", style: const TextStyle(color: Colors.orange, fontSize: 14, fontWeight: FontWeight.bold));
    tp.layout();
    tp.paint(canvas, Offset(px + 15, py - 30));
  }

  @override
  bool shouldRepaint(_DerivativePainter old) => true;
}

class _ComplexPlane extends StatelessWidget {
  final Animation<double> animation;
  const _ComplexPlane({required this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => CustomPaint(painter: _ComplexPlanePainter(animation.value), child: Container()),
    );
  }
}

class _ComplexPlanePainter extends CustomPainter {
  final double progress;
  _ComplexPlanePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final axisPaint = Paint()..color = Colors.white70..strokeWidth = 2;
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), axisPaint);
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx, size.height), axisPaint);

    final angle = progress * 2 * pi;
    final radius = size.width * 0.3;
    final x = center.dx + radius * cos(angle);
    final y = center.dy - radius * sin(angle);

    canvas.drawLine(center, Offset(x, y), Paint()..color = Colors.cyan..strokeWidth = 3);
    canvas.drawCircle(Offset(x, y), 8, Paint()..color = Colors.yellow);
    canvas.drawCircle(center, radius, Paint()..color = Colors.white30..style = PaintingStyle.stroke..strokeWidth = 1);

    final tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = const TextSpan(text: "Re", style: TextStyle(color: Colors.white, fontSize: 14));
    tp.layout(); tp.paint(canvas, Offset(size.width - 30, center.dy + 10));
    tp.text = const TextSpan(text: "Im", style: TextStyle(color: Colors.white, fontSize: 14));
    tp.layout(); tp.paint(canvas, Offset(center.dx + 10, 10));
  }

  @override
  bool shouldRepaint(_ComplexPlanePainter old) => true;
}

class _WaveGraph extends StatelessWidget {
  final Animation<double> animation;
  const _WaveGraph({required this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => CustomPaint(painter: _WavePainter(animation.value), child: Container()),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double progress;
  _WavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2);
    for (double x = 0; x <= size.width; x += 1) {
      path.lineTo(x, size.height / 2 + 50 * sin(x / 50 + progress * 2 * pi));
    }
    canvas.drawPath(path, Paint()..color = Colors.cyan..strokeWidth = 3..style = PaintingStyle.stroke);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), Paint()..color = Colors.white30..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(_WavePainter old) => true;
}

class MoleculeRenderer extends StatefulWidget {
  final String type;
  final Map<String, dynamic> data;
  const MoleculeRenderer({super.key, required this.type, required this.data});
  @override
  State<MoleculeRenderer> createState() => _MoleculeRendererState();
}

class _MoleculeRendererState extends State<MoleculeRenderer> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 4), vsync: this)..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
  }
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    switch (widget.type.toLowerCase()) {
      case "atomic_structure": return _AtomicStructure(animation: animation);
      case "electron_configuration": return _ElectronConfiguration(animation: animation);
      default: return _MolecularStructure(animation: animation);
    }
  }
}

class _AtomicStructure extends StatelessWidget {
  final Animation<double> animation;
  const _AtomicStructure({required this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => CustomPaint(painter: _AtomPainter(animation.value), child: Container()),
    );
  }
}

class _AtomPainter extends CustomPainter {
  final double progress;
  _AtomPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 25, Paint()..shader = RadialGradient(colors: [Colors.yellow, Colors.orange]).createShader(Rect.fromCircle(center: center, radius: 25)));

    final shellPaint = Paint()..color = Colors.white30..style = PaintingStyle.stroke..strokeWidth = 2;
    for (int shell = 1; shell <= 3; shell++) {
      final radius = shell * 40.0;
      canvas.drawOval(Rect.fromCenter(center: center, width: radius * 2, height: radius * 1.5), shellPaint);
      final numElectrons = shell == 1 ? 2 : 8;
      for (int e = 0; e < numElectrons; e++) {
        final angle = (e / numElectrons * 2 * pi + progress * 2 * pi);
        canvas.drawCircle(Offset(center.dx + radius * cos(angle), center.dy + radius * 0.75 * sin(angle)), 5, Paint()..color = Colors.cyan);
      }
    }

    final tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = const TextSpan(text: "Nucleus", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold));
    tp.layout(); tp.paint(canvas, Offset(center.dx - 25, center.dy + 40));
  }

  @override
  bool shouldRepaint(_AtomPainter old) => true;
}

class _MolecularStructure extends StatelessWidget {
  final Animation<double> animation;
  const _MolecularStructure({required this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => CustomPaint(painter: _MoleculePainter(animation.value), child: Container()),
    );
  }
}

class _MoleculePainter extends CustomPainter {
  final double progress;
  _MoleculePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 30, Paint()..color = Colors.red);

    for (int i = 0; i < 2; i++) {
      final angle = (i * 120 + progress * 360) * pi / 180;
      final x = center.dx + 80 * cos(angle);
      final y = center.dy + 80 * sin(angle);
      canvas.drawLine(center, Offset(x, y), Paint()..color = Colors.white70..strokeWidth = 3);
      canvas.drawCircle(Offset(x, y), 20, Paint()..color = Colors.blue);
      final tp = TextPainter(textDirection: TextDirection.ltr);
      tp.text = const TextSpan(text: "H", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold));
      tp.layout(); tp.paint(canvas, Offset(x - 6, y - 10));
    }

    final tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = const TextSpan(text: "O", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold));
    tp.layout(); tp.paint(canvas, Offset(center.dx - 7, center.dy - 12));
    tp.text = const TextSpan(text: "H₂O", style: TextStyle(color: Colors.white70, fontSize: 14));
    tp.layout(); tp.paint(canvas, Offset(center.dx - 15, center.dy + 60));
  }

  @override
  bool shouldRepaint(_MoleculePainter old) => true;
}

class _ElectronConfiguration extends StatelessWidget {
  final Animation<double> animation;
  const _ElectronConfiguration({required this.animation});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        _buildShell("K", 2, animation),
        const SizedBox(height: 20),
        _buildShell("L", 8, animation),
        const SizedBox(height: 20),
        _buildShell("M", 8, animation),
      ]),
    );
  }

  Widget _buildShell(String name, int electrons, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final filled = (electrons * animation.value).floor();
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(width: 40, child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
          ...List.generate(electrons, (i) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 20, height: 20,
            decoration: BoxDecoration(color: i < filled ? Colors.cyan : Colors.white30, shape: BoxShape.circle),
          )),
        ]);
      },
    );
  }
}

class FlowRenderer extends StatefulWidget {
  final String type;
  final Map<String, dynamic> data;
  const FlowRenderer({super.key, required this.type, required this.data});
  @override
  State<FlowRenderer> createState() => _FlowRendererState();
}

class _FlowRendererState extends State<FlowRenderer> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 5), vsync: this)..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
  }
  @override
  void dispose() { controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final step = (animation.value * 4).floor();
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildFlowStep(0, step, "Start"),
          _buildArrow(step >= 1),
          _buildFlowStep(1, step, "Process 1"),
          _buildArrow(step >= 2),
          _buildFlowStep(2, step, "Process 2"),
          _buildArrow(step >= 3),
          _buildFlowStep(3, step, "Result"),
        ]);
      },
    );
  }

  Widget _buildFlowStep(int stepNum, int currentStep, String label) {
    final isActive = stepNum <= currentStep;
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: isActive ? [Colors.blue.shade600, Colors.blue.shade800] : [Colors.grey.shade700, Colors.grey.shade800]),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isActive ? Colors.blueAccent : Colors.white30, width: 2),
        boxShadow: isActive ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)] : null,
      ),
      child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
    );
  }

  Widget _buildArrow(bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Icon(Icons.arrow_downward, color: isActive ? Colors.blueAccent : Colors.white30, size: 22),
    );
  }
}

class DefaultRenderer extends StatelessWidget {
  final String type;
  const DefaultRenderer({super.key, required this.type});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.animation, size: 80, color: Colors.white.withOpacity(0.5)),
        const SizedBox(height: 20),
        Text(type, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16)),
      ]),
    );
  }
}