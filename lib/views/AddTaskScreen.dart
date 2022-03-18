import 'package:flutter/material.dart';
import 'package:todolist/viewModels/HomeViewModel.dart';
import 'package:intl/intl.dart';
import '../models/Task.dart';

class AddTaskScreen extends StatefulWidget {
  final HomeViewModel homeViewModel;


  const AddTaskScreen({Key? key, required this.homeViewModel,
  }) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskTitleController = TextEditingController();
  final _taskDesController = TextEditingController();
  final bool _inSync = false;
  String? _taskError;


  DateTime selectedDate = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();


  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //Back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Block back button when saving
          onPressed: !_inSync
              ? () {
                  Navigator.pop(context);
                }
              : null,
        ),
        actions: <Widget>[
          // Block back button after press
          !_inSync
              ? IconButton(
                  // Save button
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    int id = widget.homeViewModel.getIDCount();
                    String dateTime = DateFormat("yyyy-MM-dd").format(selectedDate)+" "+_time.hour.toString()+":"+_time.minute.toString();
                    Task task = Task(
                        id: id,
                        title: _taskTitleController.value.text,
                        description: _taskDesController.value.text,
                        time: DateFormat("yyyy-MM-dd hh:mm")
                            .parse(dateTime));
                    widget.homeViewModel.addTask(task);
                    Navigator.pop(context);
                  },
                )
              : const Icon(Icons.refresh),
        ],
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        toolbarTextStyle: TextTheme(
          subtitle1: Theme.of(context).textTheme.titleLarge,
        ).bodyText2,
        titleTextStyle: TextTheme(
          subtitle1: Theme.of(context).textTheme.titleLarge,
        ).headline6,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (!_inSync) return true;
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  TextButton(
                      onPressed: () {
                        _selectTime();
                      },
                      child: Text(
                        _time.hour.toString() + ":" + _time.minute.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              TextField(
                controller: _taskTitleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  errorText: _taskError,
                ),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                maxLines: null,
                controller: _taskDesController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Description',
                  errorText: _taskError,
                ),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
