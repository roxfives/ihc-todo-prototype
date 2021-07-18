import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';
import 'package:todo_app/data/todo_provider.dart';
import 'package:todo_app/entities/list_entity.dart';
import 'package:todo_app/entities/todo_entity.dart';
import 'package:todo_app/utils/category.dart';
import 'package:todo_app/data/list_provider.dart';

class BoardViewExample extends StatefulWidget {
  const BoardViewExample({Key? key}) : super(key: key);

  @override
  State<BoardViewExample> createState() => _BoardViewExample();
}

class _BoardViewExample extends State<BoardViewExample> {
  late TextEditingController _controller;
  final listsProvider = ListProvider();
  final todosProvider = TodoProvider();

  //Can be used to animate to different sections of the BoardView
  final BoardViewController boardViewController = new BoardViewController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ListEntity>>(
        future: listsProvider.fetchLists(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final List<String> lists = [];

            snapshot.data.forEach((e) {
              lists.add(e.id);
            });

            return FutureBuilder<List<List<TodoEntity>>>(
              future: todosProvider.fetchTodosMultiLists(lists),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
                final List<BoardList> _lists = [];

                if (snap.hasData) {
                  for (int i = 0; i < snapshot.data.length; i++) {
                    _lists.add(_createBoardList(snapshot.data[i], snap.data[i])
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
                                      return SimpleDialog(
                                        title: Text('Criar Lista'),
                                        children: [
                                          TextField(
                                            controller: _controller,
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              listsProvider
                                                  .addList(
                                                    _controller.value.text,
                                                    '0',
                                                  )
                                                  .whenComplete(
                                                      () => setState(() {}));

                                              Navigator.pop(context);
                                            },
                                            child: Text('Adicionar'),
                                          )
                                        ],
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

                return CircularProgressIndicator();
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget buildBoardItem(TodoEntity itemObject) {
    return BoardItem(
      item: Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          child: InkWell(
            child: Column(
              children: [
                Container(
                  color: Category.getColor(itemObject.category),
                  child: ListTile(
                    leading: Icon(
                      Category.getIcon(itemObject.category),
                      color: Category.getColorContrast(itemObject.category),
                    ),
                    title: Text(itemObject.task),
                    subtitle: Text('Prazo: amanhã'),
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
                      icon: Icon(
                          itemObject.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: itemObject.isFavorite
                              ? Category.getColor(itemObject.category)
                              : Colors.black87),
                      onPressed: () {
                        /* ... */
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
      headerBackgroundColor: Colors.white60,
      backgroundColor: Colors.white60,
      header: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Center(
                  child: Text(
                    list.name,
                    style: TextStyle(fontSize: 20),
                  ),
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
              onPressed: () {},
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
}
