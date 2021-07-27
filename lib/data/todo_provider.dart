import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:todo_app/entities/todo_entity.dart';
import 'package:uuid/uuid.dart';

class TodoArray {
  List<TodoEntity> items;

  TodoArray(this.items);

  TodoArray.fromJson(Map<String, dynamic> json) : items = json['items'];

  Map<String, dynamic> toJson() =>
      {
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
      return [];
    }
  }

  Future<List<TodoEntity>> fetchTodosList(String list) async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();
      final todos = List.from(jsonDecode(contents)['items']);

      final result = todos
          .map((e) => TodoEntity.fromJson(Map<String, Object>.from(e)))
          .where((element) => element.list == list)
          .toList();

      result.sort((a, b) => a.place.compareTo(b.place));

      return result;
    } catch (e) {
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
              (list) {
            final result = todos.where((element) => element.list == list)
                .toList();
            result.sort((a, b) => a.place.compareTo(b.place));
            return result;
          })
          .toList();
    } catch (e) {
      final List<TodoEntity> todos = [];
      return lists.map((e) => todos).toList();
    }
  }

  Future<TodoEntity> fetchTodo(String id) async {
    final todos = await fetchAllTodos();
    return todos.firstWhere((element) => element.id == id);
  }

  Future<bool> addTodo(String task, String note, int category, DateTime dueDate,
      String list, int categoryColor) async {
    final file = await _localFile;

    final curr = await fetchTodosList(list);
    final todos = await fetchAllTodos();
    final json = TodoArray([
      ...todos,
      TodoEntity(
        task,
        Uuid().v4(),
        note,
        false,
        category,
        false,
        DateTime.now(),
        dueDate,
        list,
        curr.length,
        categoryColor,
      )
    ]).toJson();

    await file.writeAsString(jsonEncode(json));
    return true;
  }

  Future<bool> removeTodo(String id,) async {
    final file = await _localFile;

    final todos = await fetchAllTodos();
    todos.removeWhere((element) => element.id == id);

    final json = TodoArray(todos).toJson();

    await file.writeAsString(jsonEncode(json));
    return true;
  }

  Future<bool> editTodo(String id, {
    String? task,
    String? note,
    bool? complete,
    int? category,
    bool? isFavorite,
    DateTime? dueDate,
    String? list,
    int? place,
    int? categoryColor,
  }) async {
    final file = await _localFile;

    final todos = await fetchAllTodos();
    final i = todos.indexWhere((element) => element.id == id);

    todos[i] = TodoEntity(
      task ?? todos[i].task,
      id,
      note ?? todos[i].note,
      complete ?? todos[i].complete,
      category ?? todos[i].category,
      isFavorite ?? todos[i].isFavorite,
      todos[i].createdAt,
      dueDate ?? todos[i].dueDate,
      list ?? todos[i].list,
      place ?? todos[i].place,
      categoryColor ?? todos[i].categoryColor,
    );

    final json = TodoArray(todos).toJson();

    await file.writeAsString(jsonEncode(json));
    return true;
  }

  Future<bool> placeTodo(TodoEntity todo, String? list, int? place) async {
    final newList = list ?? todo.list;

    if (place == null) {
      await editTodo(todo.id, list: newList);
      return true;
    }

    final curr = await fetchTodosList(newList);
    curr.removeWhere((element) => element.id == todo.id);
    curr.insert(place, todo);
    for (var i = 0; i < curr.length; i++) {
      await editTodo(curr[i].id, list: newList, place: i);
    }

    return true;
  }
}
