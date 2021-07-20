import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/entities/todo_entity.dart';
import 'package:uuid/uuid.dart';

class TodoArray {
  List<TodoEntity> items;

  TodoArray(this.items);

  TodoArray.fromJson(Map<String, dynamic> json) : items = json['items'];

  Map<String, dynamic> toJson() => {
        'items': List.from(items.map((e) => e.toJson())),
      };
}

class TodoProvider {
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/todos.json');
  }

  Future<List<TodoEntity>> fetchAllTodos() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();
      final todos = List.from(jsonDecode(contents)['items']);

      return todos
          .map((e) => TodoEntity.fromJson(Map<String, Object>.from(e)))
          .toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<TodoEntity>> fetchTodosList(String list) async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();
      final todos = List.from(jsonDecode(contents)['items']);

      return todos
          .map((e) => TodoEntity.fromJson(Map<String, Object>.from(e)))
          .where((element) => element.list == list)
          .toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<List<TodoEntity>>> fetchTodosMultiLists(
      List<String> lists) async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();
      final todos = List.from(jsonDecode(contents)['items'])
          .map((e) => TodoEntity.fromJson(Map<String, Object>.from(e)))
          .toList();

      return lists
          .map(
              (list) => todos.where((element) => element.list == list).toList())
          .toList();
    } catch (e) {
      final List<TodoEntity> todos = [];
      return lists.map((e) => todos).toList();
    }
  }

  Future<bool> addTodo(String task, String note, String category,
      DateTime dueDate, String list) async {
    final file = await _localFile;

    final todos = await fetchAllTodos();
    final json = TodoArray([
      ...todos,
      TodoEntity(task, Uuid().v4(), note, false, category, false,
          DateTime.now(), dueDate, list)
    ]).toJson();

    await file.writeAsString(jsonEncode(json));
    return true;
  }
}
