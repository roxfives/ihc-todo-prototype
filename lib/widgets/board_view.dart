import 'dart:async';

import 'package:boardview/board_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/todo_provider.dart';
import 'package:todo_app/entities/list_entity.dart';
import 'package:todo_app/entities/todo_entity.dart';
import 'package:todo_app/data/list_provider.dart';
import 'package:tuple/tuple.dart';

class BoardViewExample extends StatefulWidget {
  const BoardViewExample({Key? key}) : super(key: key);

  @override
  State<BoardViewExample> createState() => _BoardViewExample();
}

class _BoardViewExample extends State<BoardViewExample> {
  late TextEditingController _controller;
  final _listsProvider = ListProvider();
  final _todosProvider = TodoProvider();

  final _formKey = GlobalKey<FormState>();

  //Can be used to animate to different sections of the BoardView
  final BoardViewController boardViewController = new BoardViewController();

  final _currentStreamCtrl = StreamController<
      Tuple2<List<ListEntity>, List<List<TodoEntity>>>>.broadcast();

  Stream<Tuple2<List<ListEntity>, List<List<TodoEntity>>>> get onChange =>
      _currentStreamCtrl.stream;

  Future<void> updateData() async {
    final _listsProvider = ListProvider();
    final _todosProvider = TodoProvider();

    final lists = await _listsProvider.fetchLists();
    if (lists.isEmpty) {
      _currentStreamCtrl.sink.add(Tuple2(lists, []));
    }
    final List<String> listsIds = lists.map((element) => element.id).toList();
    final todos = await _todosProvider.fetchTodosMultiLists(listsIds);

    _currentStreamCtrl.sink.add(Tuple2(lists, todos));
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentStreamCtrl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<Tuple2<List<ListEntity>, List<List<TodoEntity>>>>(
        stream: onChange,
        builder: (BuildContext context,
            AsyncSnapshot<Tuple2<List<ListEntity>, List<List<TodoEntity>>>>
                snapshot) {
          if (snapshot.hasData) {
            final List<BoardList> _lists = [];

            for (int i = 0; i < snapshot.data!.item1.length; i++) {
              _lists.add(_createBoardList(
                      snapshot.data!.item1[i], snapshot.data!.item2[i])
                  as BoardList);
            }

            return BoardView(
              width: 350,
              lists: [
                ..._lists,
                BoardList(
                  draggable: false,
                  backgroundColor: Colors.white60,
                  items: [
                    BoardItem(
                      draggable: false,
                      item: Container(
                        margin: EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Form(
                                  key: _formKey,
                                  child: AlertDialog(
                                      title: Text('Criar Lista'),
                                      content: TextFormField(
                                        validator: (value) {
                                          if (value == '') {
                                            return AppLocalizations.of(context)!
                                                .emptyField;
                                          }
                                          return null;
                                        },
                                        controller: _controller,
                                      ),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Cancelar'),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            if (_formKey.currentState != null &&
                                                _formKey.currentState!
                                                    .validate()) {
                                              _listsProvider
                                                  .addList(
                                                    _controller.value.text,
                                                    '0',
                                                  )
                                                  .whenComplete(
                                                      () => setState(() {
                                                            updateData();
                                                          }));

                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text('Adicionar'),
                                        ),
                                      ]),
                                );
                              },
                            );
                          },
                          child: Text('Adicionar Lista'),
                        ),
                      ),
                    )
                  ],
                ),
              ],
              boardViewController: boardViewController,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> _reorderTodo(TodoEntity todo, int? listIndex, int? place) async {
    if (listIndex != null) {
      final lists = await _listsProvider.fetchLists();
      await _todosProvider.placeTodo(todo, lists[listIndex].id, place);
    } else {
      await _todosProvider.placeTodo(todo, null, place);
    }
  }

  Widget buildBoardItem(TodoEntity itemObject) {
    return BoardItem(
      onDropItem: (listIndex, place, c, d, e) {
        _reorderTodo(itemObject, listIndex, place).then((value) => setState(() {
              updateData();
            }));
      },
      item: Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          child: InkWell(
            child: Column(
              children: [
                Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        itemObject.icon,
                        color: itemObject.color,
                      ),
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            _navigateToTodo(
                                context, itemObject.list, itemObject.id);
                            break;
                          case 'remove':
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Remover Tarefa'),
                                  content: Text(
                                      'Deseja remover essa tarefa? Esta ação é irreversível.'),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancelar'),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        _todosProvider
                                            .removeTodo(itemObject.id)
                                            .then((value) => setState(() {
                                          updateData();
                                        }));

                                        Navigator.pop(context);
                                      },
                                      child: Text('Confirmar'),
                                    ),
                                  ],
                                );
                              },
                            );
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Editar'),
                          value: 'edit',
                        ),
                        PopupMenuItem(child: Text('Remover'), value: 'remove'),
                      ],
                    ),
                    title: Text(itemObject.task),
                    subtitle: Text('Prazo: ' +
                        DateFormat('d/M/y').format(itemObject.dueDate)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    child: Text(itemObject.note),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      tooltip:
                          itemObject.isFavorite ? 'Desfavoritar' : 'Favoritar',
                      icon: Icon(
                          itemObject.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: itemObject.isFavorite
                              ? itemObject.color
                              : Colors.black87),
                      onPressed: () {
                        _todosProvider
                            .editTodo(itemObject.id,
                                isFavorite: !itemObject.isFavorite)
                            .then((value) => setState(() {
                                  updateData();
                                }));
                      },
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createBoardList(ListEntity list, List<TodoEntity> todos) {
    List<BoardItem> items = [];

    for (int i = 0; i < todos.length; i++) {
      items.insert(i, buildBoardItem(todos[i]) as BoardItem);
    }

    return BoardList(
      draggable: false,
      headerBackgroundColor: Colors.white60,
      backgroundColor: Colors.white60,
      header: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        list.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    PopupMenuButton(
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            setState(() {
                              _controller.text = list.name;
                            });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Form(
                                  key: _formKey,
                                  child: AlertDialog(
                                    title: Text('Renomear Lista'),
                                    content: TextFormField(
                                      validator: (value) {
                                        if (value == '') {
                                          return AppLocalizations.of(context)!
                                              .emptyField;
                                        }
                                        return null;
                                      },
                                      controller: _controller,
                                    ),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Cancelar'),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          if (_formKey.currentState != null &&
                                              _formKey.currentState!
                                                  .validate()) {
                                            _listsProvider
                                                .editList(
                                                  list.id,
                                                  name: _controller.value.text,
                                                )
                                                .whenComplete(
                                                    () => setState(() {
                                                          updateData();
                                                        }));

                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Text('Confirmar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            break;
                          case 'remove':
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Remover Lista'),
                                  content: Text(
                                      'Deseja remover essa lista? Esta ação é irreversível.'),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancelar'),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        _listsProvider
                                            .removeList(list.id)
                                            .then((value) => setState(() {
                                                  updateData();
                                                }));

                                        Navigator.pop(context);
                                      },
                                      child: Text('Confirmar'),
                                    ),
                                  ],
                                );
                              },
                            );
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Renomear'),
                          value: 'edit',
                        ),
                        PopupMenuItem(child: Text('Remover'), value: 'remove'),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
          ),
        ),
      ],
      items: [
        ...items,
        BoardItem(
          draggable: false,
          item: Container(
            margin: EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                _navigateToList(context, list.id);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text('Adicionar'),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void _navigateToList(BuildContext context, String id) async {
    await Navigator.pushNamed(context, '/editCard/$id');
    setState(() {
      updateData();
    });
  }

  void _navigateToTodo(
      BuildContext context, String listId, String todoId) async {
    await Navigator.pushNamed(context, '/editCard/$listId/$todoId');
    setState(() {
      updateData();
    });
  }
}
