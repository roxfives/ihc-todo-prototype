
class ListEntity {
  final bool complete;
  final String id;
  final String name;
  final String board;
  final DateTime createdAt;

  ListEntity(this.id, this.complete, this.createdAt, this.name, this.board);

  @override
  int get hashCode => complete.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListEntity &&
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
      'board': board,
    };
  }

  @override
  String toString() {
    return 'ListEntity{complete: $complete, name: $name, id: $id}';
  }

  static ListEntity fromJson(Map<String, Object> json) {
    return ListEntity(
      json['id'] as String,
      json['complete'] as bool,
      json['createdAt'] as DateTime,
      json['name'] as String,
      json['board'] as String
    );
  }
}
