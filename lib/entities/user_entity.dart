class UserEntity {
  final String id;
  final String displayName;
  final String photoUrl;
  final DateTime createdAt;

  UserEntity(this.id,  this.displayName, this.photoUrl, this.createdAt);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          displayName == other.displayName &&
          photoUrl == other.photoUrl;

  @override
  int get hashCode => id.hashCode ^ displayName.hashCode ^ photoUrl.hashCode;

  @override
  String toString() {
    return 'UserEntity{id: $id, displayName: $displayName, photoUrl: $photoUrl}';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json['id'] as String,
      json['displayName'] as String,
      json['photoUrl'] as String,
      json['createdAt'] as DateTime
    );
  }
}