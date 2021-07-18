class TodoEntity {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final String category;
  final bool isFavorite;
  final String list;
  final DateTime dueDate;
  final DateTime createdAt;

  TodoEntity(this.task, this.id, this.note, this.complete, this.category, this.isFavorite, this.createdAt, this.dueDate, this.list,);

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoEntity &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          category == other.category &&
          isFavorite == other.isFavorite &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'task': task,
      'note': note,
      'id': id,
      'category': category,
      'isFavorite': isFavorite,
      'dueDate': dueDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'list': list,
    };
  }

  @override
  String toString() {
    return 'TodoEntity{complete: $complete, task: $task, note: $note, id: $id}';
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      json['task'] as String,
      json['id'] as String,
      json['note'] as String,
      json['complete'] as bool,
      json ['category'] as String,
      json ['isFavorite'] as bool,
      DateTime.parse(json ['dueDate'] as String),
      DateTime.parse(json ['createdAt'] as String),
      json ['list'] as String,
    );
  }
}