import 'package:todo_app/entities/board_entity.dart';
import 'package:todo_app/entities/list_entity.dart';
import 'package:todo_app/entities/todo_entity.dart';

class TodoData {
  final todo1 = TodoEntity.fromJson({
    'task': 'Fazer relatório semanal',
    'id': '1',
    'note': 'O relatório semanal que deve ser entregue amanhã',
    'complete': false,
    'category': 'work',
    'isFavorite': true,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l1'
  });
  final todo2 = TodoEntity.fromJson({
    'task': 'Fazer faxina',
    'id': '2',
    'note': 'A casa está horrível',
    'complete': false,
    'category': 'house-chore',
    'isFavorite': false,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l1'
  });
  final todo3 = TodoEntity.fromJson({
    'task': 'Preparar reunião de segunda',
    'id': '3',
    'note': 'Essa reunião decidirá se tudo dará certo ou não',
    'complete': false,
    'category': 'work',
    'isFavorite': true,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l1'
  });
  final todo4 = TodoEntity.fromJson({
    'task': 'Preparar reunião de terça',
    'id': 't4',
    'note': 'Essa reunião decidirá se a de segunda deu certo ou não',
    'complete': false,
    'category': 'work',
    'isFavorite': true,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l1'
  });

  final todo5 = TodoEntity.fromJson({
    'task': 'Fazer relatório mensal',
    'id': '5',
    'note': 'O relatório mensal que deve ser entregue nesse mês',
    'complete': false,
    'category': 'work',
    'isFavorite': true,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l2'
  });
  final todo6 = TodoEntity.fromJson({
    'task': 'Trocar lâmpada da sacada',
    'id': '6',
    'note': 'Fica muito escuro lá fora',
    'complete': false,
    'category': 'house-chore',
    'isFavorite': false,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l2'
  });
  final todo7 = TodoEntity.fromJson({
    'task': 'Preparar reunião de review',
    'id': '7',
    'note': 'Essa reunião decidirá se tudo deu certo ou não',
    'complete': false,
    'category': 'work',
    'isFavorite': true,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l2'
  });
  final todo8 = TodoEntity.fromJson({
    'task': 'Preparar reunião de planejamento',
    'id': 't8',
    'note': 'Essa reunião decidirá o que será feito com o que não deu certo',
    'complete': false,
    'category': 'work',
    'isFavorite': true,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l2'
  });
  final todo9 = TodoEntity.fromJson({
    'task': 'Implementar aplicativo',
    'id': 't9',
    'note': 'Essa é a mparte mais importante da semana',
    'complete': false,
    'category': 'work',
    'isFavorite': true,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l2'
  });

  final todo10 = TodoEntity.fromJson({
    'task': 'Fazer relatório anual',
    'id': '10',
    'note': 'O relatório anual deve ser abrangente',
    'complete': false,
    'category': 'work',
    'isFavorite': true,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l3'
  });
  final todo11 = TodoEntity.fromJson({
    'task': 'Pintar a casa',
    'id': '11',
    'note': 'A casa está descascando',
    'complete': false,
    'category': 'house-chore',
    'isFavorite': false,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l3'
  });
  final todo12 = TodoEntity.fromJson({
    'task': 'Lavar o carro',
    'id': '12',
    'note': 'O carro já está de outra cor',
    'complete': false,
    'category': 'house-chore',
    'isFavorite': true,
    'createdAt': DateTime.now(),
    'dueDate': DateTime.now(),
    'list': 'l3'
  });

  final list1 = ListEntity('l1', false, DateTime.now(), 'Prioritário', 'b1');
  final list2 = ListEntity('l2', false, DateTime.now(), 'Prioridade média', 'b1');
  final list3 =
      ListEntity('l3', false, DateTime.now(), 'Menos importante', 'b1');

  final board1 = BoardEntity('b1', false, DateTime.now(), 'Board dessa semana');
  final board2 =
      BoardEntity('b2', false, DateTime.now(), 'Board da semana que vem');

  List<TodoEntity> tasksFromList(String id) {
    switch (id) {
      case 'l1':
        return [todo1, todo2, todo3, todo4];
      case 'l2':
        return [todo5, todo6, todo7, todo8, todo9];
      case 'l3':
      default:
        return [todo10, todo11, todo12];
    }
  }

  List<ListEntity> listsFromBoard(String id) {
    switch (id) {
      case 'b1':
      case 'b2':
      default:
        return [list1, list2, list3];
    }
  }

  List<BoardEntity> allBoads() {
    return [board1, board2];
  }
}
