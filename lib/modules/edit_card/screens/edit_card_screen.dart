import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/widgets/circle_painter.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class EditCard extends StatefulWidget {
  const EditCard({Key? key}) : super(key: key);

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  List<MaterialColor> colorList = [Colors.red, Colors.blue, Colors.green];

  MaterialColor? dropdownValue;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                TextFormField(
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
                    onPressed: () => [], child: const Text('Concluir'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
