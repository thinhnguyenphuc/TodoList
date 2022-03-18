import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Task.dart';

class TaskDatabase {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveTaskList(List<Task> taskList, String prefName) async {
    List<String> listTaskString = [];
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(prefName);
    for (Task task in taskList) {
      String jsonTask = jsonEncode(task);
      listTaskString.add(jsonTask);
    }
    prefs.setStringList(prefName, listTaskString);
  }

  Future<List<Task>> getTaskList(String prefName) async {
    List<Task> taskList = [];
    final SharedPreferences prefs = await _prefs;
    List<String>? taskListString = prefs.getStringList(prefName);
    if (taskListString != null) {
      for (String string in taskListString) {
        Map<String, dynamic> taskMap = jsonDecode(string);
        Task task = Task.fromJson(taskMap);
        taskList.add(task);
      }
    }
    return taskList;
  }
}
