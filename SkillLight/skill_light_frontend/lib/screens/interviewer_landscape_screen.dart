import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../services/tts_service.dart';
import '../services/stt_service.dart';
import '../services/interview_api.dart';

String _phoneToMouth(String char) {
  final c = char.toLowerCase();
  if ('aáâä'.contains(c)) return 'mouth_A';
  if ('eéêë'.contains(c)) return 'mouth_E';
  if ('fv'.contains(c)) return 'mouth_F';
  if (c == 'l') return 'mouth_L';
  if ('mbp'.contains(c)) return 'mouth_M';
  if ('oôö'.contains(c)) return 'mouth_O';
  if ('cszx'.contains(c)) return 'mouth_S';
  return 'mouth_idle';
}

class InterviewerLandscapeScreen extends StatefulWidget {
  const InterviewerLandscapeScreen({super.key});
  @override
  State<InterviewerLandscapeScreen> createState() =>
      _InterviewerLandscapeScreenState();
}

class _InterviewerLandscapeScreenState
    extends State<InterviewerLandscapeScreen> with TickerProviderStateMixin {

  static const String _baseUrl = 'http://127.0.0.1:8000';

  // ── Session — stored here AND in InterviewAPI class ───────────────
  String _sessionId = '';          // local copy
  String _currentQuestion = '';
  int _duration = 10;

  // ── Lip sync ──────────────────────────────────────────────────────
  String _mouthSvg = 'assets/mouth/mouth_idle.svg';
  Timer? _lipTimer;
  int _lipIndex = 0;

  // ── State ─────────────────────────────────────────────────────────
  bool _sessionReady = false;
  bool _interviewStarted = false;
  bool _isPaused = false;
  bool _micPermanentlyOff = false;
  bool _isListening = false;
  bool _isSpeaking = false;
  bool _isThinking = false;
  bool _isLoadingSession = true;

  // ── Timer ─────────────────────────────────────────────────────────
  int _secondsUsed = 0;
  Timer? _countdownTimer;

  // ── Notepad ───────────────────────────────────────────────────────
  bool _showNotepad = false;
  bool _notepadArrowVisible = false;
  final TextEditingController _noteController = TextEditingController();
  String _notepadFeedback = '';
  bool _evaluatingNote = false;

  // ── Resume ────────────────────────────────────────────────────────
  bool _resumeArrowVisible = false;
  bool _resumeUploading = false;
  String? _resumeUploadedName;

  // ── Transcript ────────────────────────────────────────────────────
  final List<Map<String, String>> _transcript = [];

  // ── Animation ─────────────────────────────────────────────────────
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  bool get _micOn => !_micPermanentlyOff && !_isPaused;

  // ════════════════════════════════════════════
  //  INIT
  // ════════════════════════════════════════════
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.18).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _initSession();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _duration = args?['duration'] ?? 10;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    _lipTimer?.cancel();
    _countdownTimer?.cancel();
    _pulseCtrl.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // ════════════════════════════════════════════
  //  SESSION INIT
  // ════════════════════════════════════════════
  Future<void> _initSession() async {
    setState(() => _isLoadingSession = true);
    try {
      final data = await InterviewAPI.startSession(
        durationMinutes: _duration,
      );
      // ── Store session_id in BOTH places ──────────────────────────
      _sessionId = data['session_id'] ?? '';
      debugPrint('🎯 Screen stored session_id: $_sessionId');

      setState(() {
        _currentQuestion =
            data['question'] ?? 'Welcome! Please tell me about yourself.';
        _sessionReady = true;
        _isLoadingSession = false;
      });
    } catch (e) {
      debugPrint('❌ Session init error: $e');
      setState(() {
        _currentQuestion = 'Welcome! Please tell me about yourself.';
        _sessionReady = true;
        _isLoadingSession = false;
      });
    }
  }

  // ════════════════════════════════════════════
  //  LIP SYNC
  // ════════════════════════════════════════════
  void _startLipSync(String text) {
    _lipIndex = 0;
    _lipTimer?.cancel();
    _lipTimer = Timer.periodic(const Duration(milliseconds: 90), (t) {
      if (_lipIndex >= text.length) {
        t.cancel();
        if (mounted) setState(() => _mouthSvg = 'assets/mouth/mouth_idle.svg');
        return;
      }
      if (mounted) {
        setState(() =>
        _mouthSvg = 'assets/mouth/${_phoneToMouth(text[_lipIndex])}.svg');
      }
      _lipIndex++;
    });
  }

  void _stopLipSync() {
    _lipTimer?.cancel();
    if (mounted) setState(() => _mouthSvg = 'assets/mouth/mouth_idle.svg');
  }

  // ════════════════════════════════════════════
  //  INTERVIEW FLOW
  // ════════════════════════════════════════════
  Future<void> _startInterview() async {
    if (_interviewStarted || !_sessionReady) return;
    setState(() {
      _interviewStarted = true;
      _resumeArrowVisible = true;
    });
    Future.delayed(const Duration(seconds: 5),
            () { if (mounted) setState(() => _resumeArrowVisible = false); });

    await _speakQuestion(_currentQuestion);
    _startCountdown();
    if (_micOn) _startListeningLoop();
  }

  Future<void> _speakQuestion(String text) async {
    if (mounted) setState(() => _isSpeaking = true);
    _transcript.add({'role': 'interviewer', 'text': text});
    _startLipSync(text);
    await TTSService().speak(text);
    _stopLipSync();
    if (mounted) setState(() => _isSpeaking = false);
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_isPaused) return;
      if (mounted) setState(() => _secondsUsed++);
      if (_secondsUsed >= _duration * 60) {
        t.cancel();
        _endInterview();
      }
    });
  }

  Future<void> _startListeningLoop() async {
    if (_isListening || _isPaused || _micPermanentlyOff) return;
    if (mounted) setState(() => _isListening = true);

    await STTService().startRecording();
    await Future.delayed(const Duration(seconds: 8));
    final userText = await STTService().stopAndTranscribe();

    if (mounted) setState(() => _isListening = false);

    debugPrint('🎤 STT result: "$userText"');

    if (userText.isNotEmpty && !_micPermanentlyOff && !_isPaused) {
      _transcript.add({'role': 'user', 'text': userText});
      if (mounted) setState(() => _isThinking = true);

      // ── Always pass _sessionId — never empty string ──────────────
      debugPrint('📡 Sending to backend | session=$_sessionId');
      final reply = await InterviewAPI.sendMessage(
        sessionId: _sessionId,   // local field, always up to date
        text: userText,
      );

      if (mounted) {
        setState(() {
          _isThinking = false;
          _currentQuestion = reply;
          final lower = reply.toLowerCase();
          if (['write', 'code', 'syntax', 'implement', 'function', 'program']
              .any((k) => lower.contains(k))) {
            _notepadArrowVisible = true;
            Future.delayed(const Duration(seconds: 5),
                    () { if (mounted) setState(() => _notepadArrowVisible = false); });
          }
        });
      }

      await _speakQuestion(reply);
      if (_micOn && !_isPaused && mounted) _startListeningLoop();
    } else if (!_micPermanentlyOff && !_isPaused && mounted) {
      // Silence — retry
      _startListeningLoop();
    }
  }

  void _toggleMic() {
    if (_micPermanentlyOff) {
      setState(() { _micPermanentlyOff = false; _isPaused = false; });
      if (_interviewStarted && !_isSpeaking) _startListeningLoop();
    } else {
      setState(() { _micPermanentlyOff = true; _isListening = false; });
    }
  }

  void _togglePause() {
    setState(() => _isPaused = !_isPaused);
    if (!_isPaused && _micOn && _interviewStarted) _startListeningLoop();
  }

  void _endInterview() {
    _countdownTimer?.cancel();
    _lipTimer?.cancel();
    Navigator.pushReplacementNamed(context, '/interviewResult',
        arguments: {'transcript': _transcript, 'session_id': _sessionId});
  }

  // ════════════════════════════════════════════
  //  RESUME UPLOAD
  // ════════════════════════════════════════════
  Future<void> _pickAndUploadResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      withData: true,
    );
    if (result == null || result.files.single.bytes == null) return;

    setState(() => _resumeUploading = true);
    final bytes = result.files.single.bytes!;
    final filename = result.files.single.name;

    try {
      final request =
      http.MultipartRequest('POST', Uri.parse('$_baseUrl/resume/upload'));
      request.files.add(
          http.MultipartFile.fromBytes('file', bytes, filename: filename));
      final response =
      await request.send().timeout(const Duration(seconds: 30));
      final body = await response.stream.bytesToString();
      final data = jsonDecode(body);

      setState(() {
        _resumeUploadedName = filename;
        _resumeUploading = false;
      });

      if (!_interviewStarted) {
        final name = data['name'] ?? 'there';
        final roles = (data['best_roles'] as List?)?.join(', ') ?? '';
        await _restartWithResume(name, roles, resumeText: data.toString());
      } else {
        _showSnack('✅ Resume uploaded: $filename');
      }
    } catch (e) {
      setState(() => _resumeUploading = false);
      _showSnack('❌ Upload failed. Is backend running?');
    }
  }

  Future<void> _restartWithResume(String name, String roles,
      {String resumeText = ''}) async {
    setState(() => _isLoadingSession = true);
    final data = await InterviewAPI.startSession(
      durationMinutes: _duration,
      resumeContext: resumeText,
    );
    // ── Update session_id after resume restart ──────────────────────
    _sessionId = data['session_id'] ?? _sessionId;
    debugPrint('🔄 Resume restart session_id: $_sessionId');

    setState(() {
      _currentQuestion = data['question'] ??
          'Welcome $name! You have experience in $roles. Tell me about yourself.';
      _isLoadingSession = false;
    });
    _startInterview();
  }

  // ════════════════════════════════════════════
  //  NOTEPAD EVALUATE
  // ════════════════════════════════════════════
  Future<void> _evaluateCode() async {
    final code = _noteController.text.trim();
    if (code.isEmpty) return;
    setState(() { _evaluatingNote = true; _notepadFeedback = ''; });
    _transcript.add({'role': 'user_code', 'text': code});

    try {
      final response = await http
          .post(Uri.parse('$_baseUrl/interview/evaluate-code'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'session_id': _sessionId,
            'code': code,
            'question': _currentQuestion,
          }))
          .timeout(const Duration(seconds: 20));
      final data = jsonDecode(response.body);
      final feedback = data['feedback'] ?? 'Code received.';
      setState(() { _notepadFeedback = feedback; _evaluatingNote = false; });
      await _speakQuestion(feedback);
      if (_micOn) _startListeningLoop();
    } catch (e) {
      setState(() {
        _notepadFeedback = 'Connection error. Please try again.';
        _evaluatingNote = false;
      });
    }
  }

  void _showSnack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 3)));

  String get _timerText {
    final rem = (_duration * 60) - _secondsUsed;
    return '${(rem ~/ 60).toString().padLeft(2, '0')}:${(rem % 60).toString().padLeft(2, '0')}';
  }

  Color get _timerColor {
    final rem = (_duration * 60) - _secondsUsed;
    if (rem < 60) return Colors.red;
    if (rem < 180) return Colors.orange;
    return Colors.greenAccent;
  }

  // ════════════════════════════════════════════
  //  BUILD
  // ════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: SafeArea(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [Color(0xFF0D0D1A), Color(0xFF1A1A2E), Color(0xFF16213E)],
              ),
            ),
          ),
          if (_isLoadingSession)
            Container(
              color: Colors.black.withOpacity(0.75),
              child: const Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  CircularProgressIndicator(color: Colors.blue),
                  SizedBox(height: 18),
                  Text('Connecting to AI Interviewer...',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ]),
              ),
            )
          else ...[
            Row(children: [
              Expanded(flex: 5, child: _buildInterviewerPanel()),
              Expanded(flex: 4, child: _buildRightPanel()),
            ]),
            _buildFloatingButtons(),
            _buildTopBar(),
            if (_showNotepad) _buildNotepadOverlay(),
            if (_resumeArrowVisible) _buildResumeArrowHint(),
            if (_notepadArrowVisible) _buildNotepadArrowHint(),
            if (!_interviewStarted) _buildStartButton(),
          ],
        ]),
      ),
    );
  }

  Widget _buildInterviewerPanel() {
    return Stack(alignment: Alignment.center, children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 280, height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(
            color: _isSpeaking ? Colors.blue.withOpacity(0.35) : Colors.transparent,
            blurRadius: 60, spreadRadius: 20,
          )],
        ),
      ),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Stack(alignment: Alignment.bottomCenter, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/images/ai_interviewer.png',
                height: 240, fit: BoxFit.contain),
          ),
          Positioned(
            bottom: 52,
            child: SvgPicture.asset(_mouthSvg, width: 60, height: 28,
              colorFilter: const ColorFilter.mode(
                  Color(0xFFD4A574), BlendMode.multiply),
            ),
          ),
        ]),
        const SizedBox(height: 8),
        _buildStatusChip(),
      ]),
    ]);
  }

  Widget _buildStatusChip() {
    String label; Color color; IconData icon;
    if (_isLoadingSession) { label = 'Connecting...'; color = Colors.grey; icon = Icons.cloud_sync; }
    else if (_isThinking)  { label = 'Thinking...';  color = Colors.amber; icon = Icons.psychology; }
    else if (_isSpeaking)  { label = 'Speaking';     color = Colors.blue;  icon = Icons.record_voice_over; }
    else if (_isListening) { label = 'Listening...'; color = Colors.green; icon = Icons.mic; }
    else if (_isPaused)    { label = 'Paused';       color = Colors.orange; icon = Icons.pause_circle; }
    else                   { label = 'AI Interviewer'; color = Colors.grey; icon = Icons.person; }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: color, size: 14), const SizedBox(width: 6),
        Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
      ]),
    );
  }

  Widget _buildRightPanel() {
    return Padding(
      padding: const EdgeInsets.only(right: 72, top: 40, bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Container(
            width: double.infinity, margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2A3A), borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text('🎙️ INTERVIEWER', style: TextStyle(
                        color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                  const Spacer(),
                  if (_isThinking)
                    const SizedBox(width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.amber)),
                ]),
                const SizedBox(height: 10),
                Text(_currentQuestion.isEmpty ? 'Loading...' : _currentQuestion,
                    style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5)),
              ]),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (_isListening)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withOpacity(0.4)),
            ),
            child: Row(children: [
              Row(children: List.generate(5, (i) => AnimatedBuilder(
                animation: _pulseAnim,
                builder: (_, __) => Container(
                  width: 3, height: (8 + (i % 3) * 6) * _pulseAnim.value,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(color: Colors.green,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ))),
              const SizedBox(width: 10),
              const Text('Your turn — speak now...',
                  style: TextStyle(color: Colors.green, fontSize: 13)),
            ]),
          ),
      ]),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0, left: 0, right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
        )),
        child: Row(children: [
          const Text('AI INTERVIEW', style: TextStyle(color: Colors.white,
              fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const Spacer(),
          if (_interviewStarted) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(color: _timerColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _timerColor.withOpacity(0.5)),
              ),
              child: Row(children: [
                Icon(Icons.timer, color: _timerColor, size: 14),
                const SizedBox(width: 6),
                Text(_timerText, style: TextStyle(color: _timerColor, fontSize: 14,
                    fontWeight: FontWeight.bold, fontFamily: 'monospace')),
              ]),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _endInterview,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red.withOpacity(0.5)),
                ),
                child: const Row(children: [
                  Icon(Icons.stop_circle, color: Colors.red, size: 14),
                  SizedBox(width: 6),
                  Text('End', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
          ],
        ]),
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return Positioned(
      right: 12, top: 0, bottom: 0,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        _FloatBtn(
          icon: _micPermanentlyOff ? Icons.mic_off : Icons.mic,
          color: _micPermanentlyOff ? Colors.red : Colors.green,
          tooltip: _micPermanentlyOff ? 'Mic Off — tap to resume' : 'Mic On',
          pulse: _isListening && !_micPermanentlyOff, pulseAnim: _pulseAnim,
          onTap: _interviewStarted ? _toggleMic : null,
        ),
        const SizedBox(height: 14),
        _FloatBtn(
          icon: _isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
          color: Colors.amber, tooltip: _isPaused ? 'Resume' : 'Pause',
          onTap: _interviewStarted ? _togglePause : null,
        ),
        const SizedBox(height: 14),
        _FloatBtn(
          icon: Icons.edit_note_rounded, color: Colors.purple,
          tooltip: 'Code Notepad', badge: _notepadArrowVisible,
          onTap: () => setState(() => _showNotepad = !_showNotepad),
        ),
        const SizedBox(height: 14),
        _FloatBtn(
          icon: _resumeUploading ? Icons.hourglass_top
              : (_resumeUploadedName != null ? Icons.check_circle : Icons.upload_file),
          color: _resumeUploadedName != null ? Colors.teal : Colors.blue,
          tooltip: 'Upload Resume', badge: _resumeArrowVisible,
          onTap: _resumeUploading ? null : _pickAndUploadResume,
        ),
      ]),
    );
  }

  Widget _buildNotepadOverlay() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() => _showNotepad = false),
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.height * 0.78,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1F2E), borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.purple.withOpacity(0.4)),
                ),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(color: Colors.purple.withOpacity(0.15),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
                    child: Row(children: [
                      const Icon(Icons.code, color: Colors.purple, size: 18),
                      const SizedBox(width: 8),
                      const Text('Code / Notes', style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 15)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => setState(() => _showNotepad = false),
                        child: const Icon(Icons.close, color: Colors.grey, size: 20),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(color: const Color(0xFF0D1117),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.purple.withOpacity(0.3)),
                        ),
                        child: TextField(
                          controller: _noteController, maxLines: null, expands: true,
                          style: const TextStyle(color: Color(0xFF79C0FF),
                              fontFamily: 'monospace', fontSize: 13, height: 1.6),
                          decoration: const InputDecoration(
                            hintText: '// Write your code here...',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.all(12), border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_notepadFeedback.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green.withOpacity(0.3)),
                      ),
                      child: Text(_notepadFeedback,
                          style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _evaluatingNote ? null : _evaluateCode,
                        icon: _evaluatingNote
                            ? const SizedBox(width: 16, height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Icon(Icons.send_rounded),
                        label: Text(_evaluatingNote ? 'Evaluating...' : 'Submit Code'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple, foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResumeArrowHint() => Positioned(
    right: 68, bottom: 20,
    child: _ArrowHint(text: 'Upload your\nresume here!', color: Colors.blue),
  );

  Widget _buildNotepadArrowHint() => Positioned(
    right: 68, top: MediaQuery.of(context).size.height * 0.38,
    child: _ArrowHint(text: 'Write your\ncode here!', color: Colors.purple),
  );

  Widget _buildStartButton() {
    return Positioned(
      bottom: 24, left: 0, right: 80,
      child: Center(
        child: GestureDetector(
          onTap: _startInterview,
          child: AnimatedBuilder(
            animation: _pulseAnim,
            builder: (_, child) => Transform.scale(scale: _pulseAnim.value, child: child),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF2979FF), Color(0xFF00BCD4)]),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.4),
                    blurRadius: 20, spreadRadius: 2)],
              ),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.play_arrow_rounded, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text('Start Interview', style: TextStyle(color: Colors.white,
                    fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Floating Button ──────────────────────────────────────────────────
class _FloatBtn extends StatelessWidget {
  final IconData icon; final Color color; final String tooltip;
  final VoidCallback? onTap; final bool pulse; final bool badge;
  final Animation<double>? pulseAnim;
  const _FloatBtn({required this.icon, required this.color,
    required this.tooltip, this.onTap, this.pulse = false,
    this.badge = false, this.pulseAnim});

  @override
  Widget build(BuildContext context) {
    Widget btn = Tooltip(
      message: tooltip, preferBelow: false,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 50, height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(onTap == null ? 0.08 : 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(onTap == null ? 0.2 : 0.6), width: 1.5),
            boxShadow: onTap != null
                ? [BoxShadow(color: color.withOpacity(0.3), blurRadius: 12, spreadRadius: 1)]
                : null,
          ),
          child: Icon(icon, color: color.withOpacity(onTap == null ? 0.3 : 1.0), size: 22),
        ),
      ),
    );
    if (pulse && pulseAnim != null) {
      btn = AnimatedBuilder(animation: pulseAnim!,
          builder: (_, child) => Transform.scale(scale: pulseAnim!.value, child: child),
          child: btn);
    }
    if (badge) {
      btn = Stack(clipBehavior: Clip.none, children: [
        btn,
        Positioned(top: -2, right: -2,
          child: Container(width: 12, height: 12,
              decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle)),
        ),
      ]);
    }
    return btn;
  }
}

// ── Arrow Hint ───────────────────────────────────────────────────────
class _ArrowHint extends StatelessWidget {
  final String text; final Color color;
  const _ArrowHint({required this.text, required this.color});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Text(text, textAlign: TextAlign.center,
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
      ),
      const SizedBox(width: 4),
      Icon(Icons.arrow_forward_ios, color: color, size: 16),
    ]);
  }
}
