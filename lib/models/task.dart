class Task {
  final String id;
  final String task;

  Task({required this.id, required this.task});

  factory Task.fromMap(Map teskMap) {
    return Task(
      id: teskMap['id'] ?? '',
      task: teskMap['task'] ?? 'No Task',
    );
  }
}
