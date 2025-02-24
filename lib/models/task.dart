class Task {
  final String id;
  final String task;

  Task({required this.id, required this.task});

  factory Task.fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      task: taskMap['task'],
    );
  }
}
