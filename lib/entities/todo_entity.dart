import 'package:flutter/material.dart';

class TodoEntity {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final int category;
  final bool isFavorite;
  final String list;
  final DateTime dueDate;
  final DateTime createdAt;
  final int place;
  final int categoryColor;

  MaterialColor get color => getColor(categoryColor);

  String get colorName => getColorName(categoryColor);

  IconData get icon => getIcon(category);

  static getColor(int value) {
    if (value == 0) {
      return Colors.red;
    } else if (value == 1) {
      return Colors.blue;
    } else if (value == 2) {
      return Colors.green;
    }
    return Colors.grey;
  }

  static getColorName(int value) {
    if (value == 0) {
      return 'Vermelho';
    } else if (value == 1) {
      return 'Azul';
    } else if (value == 2) {
      return 'Verde';
    }
    return '';
  }

  static getIcon(int value) {
    if (value == 0) {
      return Icons.work;
    } else if (value == 1) {
      return Icons.people;
    } else if (value == 2) {
      return Icons.house;
    }
    return Icons.place;
  }

  static getIconName(int value) {
    if (value == 0) {
      return 'Trabalho';
    } else if (value == 1) {
      return 'Social';
    } else if (value == 2) {
      return 'Casa';
    }
    return '';
  }

  TodoEntity(
    this.task,
    this.id,
    this.note,
    this.complete,
    this.category,
    this.isFavorite,
    this.createdAt,
    this.dueDate,
    this.list,
    this.place,
    this.categoryColor,
  );

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
          id == other.id &&
          categoryColor == other.categoryColor &&
          place == other.place;

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
      'place': place,
      'categoryColor': categoryColor,
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
      json['category'] as int,
      json['isFavorite'] as bool,
      DateTime.parse(json['dueDate'] as String),
      DateTime.parse(json['createdAt'] as String),
      json['list'] as String,
      json['place'] as int,
      json['categoryColor'] as int,
    );
  }
}
