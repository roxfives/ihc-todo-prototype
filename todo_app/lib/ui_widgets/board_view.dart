import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';

import '../BoardItemObject.dart';
import '../BoardListObject.dart';

class BoardViewExample extends StatelessWidget {
  // final List<BoardItemObject> itemsListOne = ;

  List<BoardListObject> _listData = [
    BoardListObject(title: "List title 1", items: [
      BoardItemObject(title: 'Item 1'),
      BoardItemObject(title: 'Item 2'),
      BoardItemObject(title: 'Item 3'),
    ]),
    BoardListObject(title: "List title 2", items: [
      BoardItemObject(title: 'Item 1'),
      BoardItemObject(title: 'Item 2'),
      BoardItemObject(title: 'Item 3'),
    ]),
    BoardListObject(title: "List title 3", items: [
      BoardItemObject(title: 'Item 1'),
      BoardItemObject(title: 'Item 2'),
      BoardItemObject(title: 'Item 3'),
    ])
  ];

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = new BoardViewController();

  @override
  Widget build(BuildContext context) {
    List<BoardList> _lists = [];
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(_listData[i]) as BoardList);
    }
    return Center(
      child: BoardView(
        lists: _lists,
        boardViewController: boardViewController,
      ),
    );
  }

  Widget buildBoardItem(BoardItemObject itemObject) {
    return BoardItem(
        onStartDragItem:
            (int? listIndex, int? itemIndex, BoardItemState? state) {},
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
            int? oldItemIndex, BoardItemState? state) {
          //Used to update our local item data
          var item = _listData[oldListIndex!].items![oldItemIndex!];
          _listData[oldListIndex].items!.removeAt(oldItemIndex);
          _listData[listIndex!].items!.insert(itemIndex!, item);
        },
        onTapItem:
            (int? listIndex, int? itemIndex, BoardItemState? state) async {},
        item: Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: InkWell(
              // splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                print('Card tapped.');
              },
              child: Column(
                children: [
                  Container(
                    color: Colors.red[100],
                    child: ListTile(
                      leading: Icon(
                        Icons.work,
                        color: Colors.black87,
                      ),
                      title: Text(itemObject.title),
                      subtitle: Text('Prazo: amanhã'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      child: Text(
                          'Texto do card falando sobre oq o todo do card é'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.black87,
                        ),
                        onPressed: () {/* ... */},
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _createBoardList(BoardListObject list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items!.length; i++) {
      items.insert(i, buildBoardItem(list.items![i]) as BoardItem);
    }

    return BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex!];
        _listData.removeAt(oldListIndex);
        _listData.insert(listIndex!, list);
      },
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        list.title!,
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
                ))),
      ],
      items: items,
    );
  }
}
