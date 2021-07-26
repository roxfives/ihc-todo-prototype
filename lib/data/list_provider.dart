import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/entities/list_entity.dart';
import 'package:uuid/uuid.dart';

class ListArray {
  List<ListEntity> items;

  ListArray(this.items);

  ListArray.fromJson(Map<String, dynamic> json) : items = json['items'];

  Map<String, dynamic> toJson() => {
        'items': List.from(items.map((e) => e.toJson())),
      };
}

class ListProvider {
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/lists.json');
  }

  Future<List<ListEntity>> fetchLists() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();
      final lists = List.from(jsonDecode(contents)['items']);

      return lists
          .map((e) => ListEntity.fromJson(Map<String, Object>.from(e)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addList(String name, String board) async {
    final file = await _localFile;

    final lists = await fetchLists();
    final json = ListArray([
      ...lists,
      ListEntity(Uuid().v4(), false, new DateTime.now(), name, board)
    ]).toJson();

    await file.writeAsString(jsonEncode(json));
    return true;
  }

  Future<bool> removeList(String id) async {
    final file = await _localFile;

    final lists = await fetchLists();
    lists.removeWhere((element) => element.id == id);

    final json = ListArray(lists).toJson();

    await file.writeAsString(jsonEncode(json));
    return true;
  }

  Future<bool> editList(
    String id, {
    String? name,
    String? board,
    bool? complete,
  }) async {
    final file = await _localFile;

    final lists = await fetchLists();
    final i = lists.indexWhere((element) => element.id == id);
    lists[i] = ListEntity(
      id,
      complete ?? lists[i].complete,
      lists[i].createdAt,
      name ?? lists[i].name,
      board ?? lists[i].board,
    );

    final json = ListArray(lists).toJson();

    await file.writeAsString(jsonEncode(json));
    return true;
  }
}
