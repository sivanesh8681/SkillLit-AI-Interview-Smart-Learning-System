enum EventType {
  speak,
  boardHeading,
  boardWrite,
  boardFormula,
  showDiagram,
  showGraph,
  animate,
  clearBoard,
  pause
}

class ScriptEvent {
  final double time; // seconds from start
  final EventType type;
  final String? text;
  final String? asset;
  final String? latex;

  ScriptEvent({
    required this.time,
    required this.type,
    this.text,
    this.asset,
    this.latex,
  });

  factory ScriptEvent.fromJson(Map<String, dynamic> json) {
    return ScriptEvent(
      time: (json['t'] as num).toDouble(),
      type: EventType.values.firstWhere(
            (e) => e.name == json['type'],
      ),
      text: json['text'],
      asset: json['asset'],
      latex: json['latex'],
    );
  }
}
