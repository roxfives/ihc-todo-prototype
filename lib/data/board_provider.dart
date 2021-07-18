import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/entities/list_entity.dart';

class BoardProvider {
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/boards.json');
  }

  Future<List<ListEntity>> fetchBoards() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();
      final boards = jsonDecode(contents);

      log(boards);

      return boards;
    } catch (e) {
      return [];
    }
  }
}