import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';
import 'package:todo_app/data/todo_data.dart';
import 'package:todo_app/entities/board_entity.dart';
import 'package:todo_app/entities/list_entity.dart';
import 'package:todo_app/entities/todo_entity.dart';
import 'package:todo_app/utils/category.dart';

class BoardViewExample extends StatelessWidget {
  final todoData = new TodoData();

  //Can be used to animate to different sections of the BoardView
  final BoardViewController boardViewController = new BoardViewController();

  @override
  Widget build(BuildContext context) {
    List<BoardEntity> _boardsData = todoData.allBoads();
    List<ListEntity> _listData = todoData.listsFromBoard(_boardsData[0].id);
    List<BoardList> _lists = [];

    for (int i = 0; i < _listData.length; i++) {
      _lists.add(
          _createBoardList(_listData[i]) as BoardList);
    }
    return Center(
      child: BoardView(
        width: 350,
        lists: _lists,
        boardViewController: boardViewController,
      ),
    );
  }

  Widget buildBoardItem(TodoEntity itemObject) {
    return BoardItem(
      onStartDragItem:
          (int? listIndex, int? itemIndex, BoardItemState? state) {},
      onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
          int? oldItemIndex, BoardItemState? state) {
        //Used to update our local item data
        // var item = _listData[oldListIndex!].items![oldItemIndex!];

        // _listData[oldListIndex].items!.removeAt(oldItemIndex);
        // _listData[listIndex!].items!.insert(itemIndex!, item);
      },
      onTapItem:
          (int? listIndex, int? itemIndex, BoardItemState? state) async {},
      item: Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          child: InkWell(
            // splashColor: Colors.blue.withAlpha(30),
            onTap: () {},
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

  Widget _createBoardList(ListEntity list) {
    List<TodoEntity> tasks = todoData.tasksFromList(list.id);
    List<BoardItem> items = [];

    for (int i = 0; i < tasks.length; i++) {
      items.insert(i, buildBoardItem(tasks[i]) as BoardItem);
    }

    return BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {
        //Update our local list data
        // var list = _listData[oldListIndex!];
        // _listData.removeAt(oldListIndex);
        // _listData.insert(listIndex!, list);
      },
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
      items: items,
    );
  }
}
