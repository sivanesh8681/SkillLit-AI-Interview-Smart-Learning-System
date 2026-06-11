class TimelineEvent {
  final String id;
  final String type; // speak | write | animate
  final String? text;
  final String? animation;

  TimelineEvent({
    required this.id,
    required this.type,
    this.text,
    this.animation,
  });

  factory TimelineEvent.fromJson(Map<String, dynamic> json) {
    return TimelineEvent(
      id: json["id"],
      type: json["type"],
      text: json["text"],
      animation: json["animation"],
    );
  }
}
