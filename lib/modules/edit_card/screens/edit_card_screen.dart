import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/list_provider.dart';
import 'package:todo_app/data/todo_provider.dart';
import 'package:todo_app/entities/list_entity.dart';
import 'package:todo_app/widgets/circle_painter.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class EditCard extends StatefulWidget {
  const EditCard({Key? key, this.listId, this.todoId}) : super(key: key);

  final String? listId;
  final String? todoId;

  @override
  State<EditCard> createState() =>
      _EditCardState(listId: this.listId, todoId: this.todoId);
}

class _EditCardState extends State<EditCard> {
  String? listId;
  String? todoId;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _listProvider = ListProvider();
  final _todosProvider = TodoProvider();

  int _dropdownValue = 0;
  String _listValue = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> fetchAndSetTodo(String id) async {
    final todo = await _todosProvider.fetchTodo(id);

    setState(() {
      _nameController.text = todo.task;
      _descriptionController.text = todo.note;
      _dropdownValue = int.parse(todo.category);
      _selectedDate = todo.dueDate;
      _selectedTime = TimeOfDay.fromDateTime(todo.dueDate);
    });
  }

  _EditCardState({this.listId, this.todoId}) {
    _listValue = this.listId ?? '';
    if (this.todoId != null) {
      fetchAndSetTodo(this.todoId!);
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat.yMd().add_jm().format(DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTime.hour,
            _selectedTime.minute));
      });
      _selectTime(context);
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null)
      setState(() {
        _selectedTime = picked;
        _dateController.text = DateFormat.yMd().add_jm().format(DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTime.hour,
            _selectedTime.minute));
      });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    MaterialColor getColor(int item) {
      if (item == 0) {
        return Colors.red;
      } else if (item == 1) {
        return Colors.blue;
      } else if (item == 2) {
        return Colors.green;
      }
      return Colors.grey;
    }

    String getColorName(int item) {
      if (item == 0) {
        return 'Vermelho';
      } else if (item == 1) {
        return 'Azul';
      } else if (item == 2) {
        return 'Verde';
      }
      return '';
    }

    List<DropdownMenuItem<int>> items = [0, 1, 2].map((item) {
      return DropdownMenuItem<int>(
        value: item,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Semantics(
            label: getColorName(item),
            child: CustomPaint(
              foregroundPainter: CirclePainter(
                8.0,
                getColor(item),
              ),
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('O que vamos fazer hoje, Patrícia?',
                  style: DefaultTextStyle.of(context).style.apply(
                      fontSizeFactor: 0.6,
                      color: Colors.white,
                      decoration: TextDecoration.none)),
            ),
            ListTile(
              title: Text('Board Principal'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Board Secundária'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Sem notificações no momento',
                      style: DefaultTextStyle.of(context).style.apply(
                          fontSizeFactor: 0.3,
                          color: Colors.white,
                          decoration: TextDecoration.none)),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: this.todoId != null
            ? Text(AppLocalizations.of(context)!.editCard)
            : Text('Criar Tarefa'),
        actions: [
          IconButton(
            tooltip: 'Notificações', //localization.starterAppTooltipFavorite,
            icon: const Icon(
              Icons.notifications,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder<List<ListEntity>>(
                    future: _listProvider.fetchLists(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
                          value: _listValue,
                          validator: (value) {
                            if (value == '') {
                              return AppLocalizations.of(context)!.emptyField;
                            }
                            return null;
                          },
                          onChanged: (String? newValue) {
                            setState(() {
                              _listValue = newValue!;
                            });
                          },
                          items: [
                            ListEntity('', false, DateTime.now(),
                                'Selecione uma lista', '0'),
                            ...snapshot.data!
                          ]
                              .map((e) => DropdownMenuItem<String>(
                                    value: e.id,
                                    child: Text(e.name),
                                  ))
                              .toList(),
                        );
                      }
                      return CircularProgressIndicator();
                    }),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.cardName),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.emptyField;
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.nextFocus(),
                ),
                // SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.cardDescription,
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.nextFocus(),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: TextFormField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _dateController,
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(),
                            labelText:
                                AppLocalizations.of(context)!.cardDueDate,
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.only(top: 11),
                      width: 50,
                      child: DropdownButtonFormField(
                        value: _dropdownValue,
                        onChanged: (int? newValue) {
                          setState(() {
                            _dropdownValue = newValue!;
                          });
                        },
                        items: items,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ElevatedButton(
                    onPressed: () => {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate())
                            {
                              if (this.todoId != null)
                                {
                                  _todosProvider
                                      .editTodo(
                                        this.todoId!,
                                        task: _nameController.text,
                                        note: _descriptionController.text,
                                        category: _dropdownValue.toString(),
                                        dueDate: DateTime(
                                          _selectedDate.year,
                                          _selectedDate.month,
                                          _selectedDate.day,
                                          _selectedTime.hour,
                                          _selectedTime.minute,
                                        ),
                                        list: _listValue,
                                      )
                                      .then(
                                        (value) => Navigator.pop(context),
                                      ),
                                }
                              else
                                {
                                  _todosProvider
                                      .addTodo(
                                        _nameController.text,
                                        _descriptionController.text,
                                        _dropdownValue.toString(),
                                        DateTime(
                                          _selectedDate.year,
                                          _selectedDate.month,
                                          _selectedDate.day,
                                          _selectedTime.hour,
                                          _selectedTime.minute,
                                        ),
                                        _listValue,
                                      )
                                      .then(
                                        (value) => Navigator.pop(context),
                                      ),
                                }
                            }
                        },
                    child: const Text('Concluir'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
