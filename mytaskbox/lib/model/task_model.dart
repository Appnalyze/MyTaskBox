class Task {
  final int id;
  final String title;
  final String description;
  final String? category;
  final DateTime? deadline;
  final String? priority;
  final bool? done;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.category,
    this.deadline,
    this.priority,
    this.done,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'] ?? '',
        description: json['description'],
        category: json['category'],
        deadline:
            json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
        priority: json['priority'],
        done: json['Done'],
      );
}
