import 'dart:async';
import 'script_event.dart';

class TeacherEngine {
  final List<ScriptEvent> events;
  final Function(ScriptEvent) onEvent;

  Timer? _timer;
  double _currentTime = 0;
  int _currentIndex = 0;

  TeacherEngine({
    required this.events,
    required this.onEvent,
  });

  void start() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _currentTime += 0.1;
      _checkEvents();
    });
  }

  void _checkEvents() {
    if (_currentIndex >= events.length) return;

    final event = events[_currentIndex];

    if (_currentTime >= event.time) {
      onEvent(event);
      _currentIndex++;
    }
  }

  void stop() {
    _timer?.cancel();
  }

  void reset() {
    stop();
    _currentTime = 0;
    _currentIndex = 0;
  }
}
