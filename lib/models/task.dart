class Task {
  Task({
    required this.id,
    required this.title,
  });

  String id;
  String title;

  static final empty = Task(id: 'id', title: 'title');

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['title'] = title;
    return data;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
    );
  }
}
