class Task {
  Task({required this.id, required this.title, this.isDone = false});

  String id;
  String title;
  bool isDone;

  static final empty = Task(
    id: 'id',
    title: 'title',
    isDone: false,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['title'] = title;
    data['isDone'] = isDone;
    return data;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
    );
  }
}
