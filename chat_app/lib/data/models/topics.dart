class Topics {
  String content;
  int level;
  bool isComplete = false;
  Topics({
    required this.content,
    required this.level,
  });

  factory Topics.fromJson(Map<String, dynamic> json) => Topics(
        content: json["content"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "level": level,
      };
}
