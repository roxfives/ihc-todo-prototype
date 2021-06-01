class BoardEntity {
  final bool complete;
  final String id;
  final String name;
  final DateTime createdAt;

  BoardEntity(this.id, this.complete, this.createdAt, this.name);

  @override
  int get hashCode => complete.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardEntity &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          id == other.id &&
          name == other.name &&
          createdAt == other.createdAt;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'id': id,
      'name': name,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'BoardEntity{complete: $complete, name: $name, id: $id}';
  }

  static BoardEntity fromJson(Map<String, Object> json) {
    return BoardEntity(
      json['id'] as String,
      json['complete'] as bool,
      json['createdAt'] as DateTime,
      json['name'] as String,
    );
  }
}
