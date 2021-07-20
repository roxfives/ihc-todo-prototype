import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/list_provider.dart';
import 'package:todo_app/data/todo_provider.dart';
import 'package:todo_app/entities/list_entity.dart';
import 'package:todo_app/widgets/circle_painter.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class EditCard extends StatefulWidget {
  const EditCard({Key? key, this.listId}) : super(key: key);

  final String? listId;

  @override
  State<EditCard> createState() => _EditCardState(listId: this.listId);
}

class _EditCardState extends State<EditCard> {
  String? listId;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final listProvider = ListProvider();
  final todosProvider = TodoProvider();
  final List<MaterialColor> colorList = [Colors.red, Colors.blue, Colors.green];

  MaterialColor dropdownValue = Colors.red;
  String listValue = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  _EditCardState({this.listId}) {
    listValue = this.listId ?? '';
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().add_jm().format(DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute));
      });
      _selectTime(context);
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _dateController.text = DateFormat.yMd().add_jm().format(DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute));
      });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    List<DropdownMenuItem<MaterialColor>> items = colorList.map((item) {
      return DropdownMenuItem<MaterialColor>(
        value: item,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CustomPaint(
            foregroundPainter: CirclePainter(8.0, item),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (_formKey.currentState != null &&
      //         _formKey.currentState!.validate()) {
      //       todosProvider
      //           .addTodo(
      //               _nameController.text,
      //               _descriptionController.text,
      //               dropdownValue.value.toString(),
      //               DateTime(
      //                   selectedDate.year,
      //                   selectedDate.month,
      //                   selectedDate.day,
      //                   selectedTime.hour,
      //                   selectedTime.minute),
      //               listValue)
      //           .then((value) => Navigator.pop(context));
      //     }
      //   },
      //   child: Icon(Icons.check),
      // ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.editCard),
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
                    future: listProvider.fetchLists(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
                          value: listValue,
                          validator: (value) {
                            if (value == '') {
                              return AppLocalizations.of(context)!.emptyField;
                            }
                            return null;
                          },
                          onChanged: (String? newValue) {
                            setState(() {
                              listValue = newValue!;
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
                        value: dropdownValue,
                        onChanged: (MaterialColor? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
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
                              todosProvider
                                  .addTodo(
                                      _nameController.text,
                                      _descriptionController.text,
                                      dropdownValue.value.toString(),
                                      DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          selectedTime.hour,
                                          selectedTime.minute),
                                      listValue)
                                  .then((value) => Navigator.pop(context))
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
