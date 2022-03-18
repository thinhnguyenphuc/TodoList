import 'package:flutter/material.dart';
import 'package:todolist/database/TaskDatabase.dart';

import '../models/Task.dart';

class HomeViewModel with ChangeNotifier {
  static late List<Task> _taskList = [];
  static final List<Task> _searchTaskList = [];
  static final List<Task> _todayTaskList = [];
  static final List<Task> _upcomingTaskList = [];
  static late List<Task> _doneTaskList = [];
  static int _idCount = 0;
  static TaskDatabase taskDatabase = TaskDatabase();
  bool loaded = false;

  HomeViewModel() {
    _initTaskList();
    _initDoneTaskList();
  }

  bool isLoaded(){
    return loaded;
  }
  
  void _initTaskList() async {
    await taskDatabase
        .getTaskList("taskList")
        .then((value) => _taskList = value)
        .whenComplete(() =>
            {_initUpComingList(), _initTodayList(), loaded = true});
  }

  void _initDoneTaskList() async {
    await taskDatabase.getTaskList("doneList").then((value) => _doneTaskList = value);
  }

  void _initTodayList() {
    _todayTaskList.clear();
    for (Task task in _taskList) {
      if (task.time.day == DateTime.now().day) {
        _todayTaskList.add(task);
      }
    }
  }

  void _initUpComingList() {
    _upcomingTaskList.clear();
    for (Task task in _taskList) {
      if (task.time.day == DateTime.now().day + 1) {
        _upcomingTaskList.add(task);
      }
    }
  }

  void addTask(Task task) {
    _taskList.add(task);
    _initTodayList();
    _initUpComingList();
    taskDatabase.saveTaskList(_taskList, "taskList");
  }

  void addDoneTask(Task task) {
    _doneTaskList.add(task);
    taskDatabase.saveTaskList(_doneTaskList, "doneList");
  }

  void deleteDoneTask(Task task) {
    for (Task item in _doneTaskList) {
      if (item.id == task.id) {
        _doneTaskList.remove(item);
        break;
      }
    }
    taskDatabase.saveTaskList(_doneTaskList, "doneList");
  }

  List<Task> getTaskList() {
    return _taskList;
  }

  List<Task> getTodayTaskList() {
    return _todayTaskList;
  }

  List<Task> getUpcomingTaskList() {
    return _upcomingTaskList;
  }

  List<Task> getSearchTaskList() {
    return _searchTaskList;
  }

  List<Task> getDoneTaskList() {
    return _doneTaskList;
  }

  void deleteTask(Task task) {
    for (Task item in _taskList) {
      if (item.id == task.id) {
        _taskList.remove(item);
        _initUpComingList();
        _initTodayList();
        break;
      }
    }
    taskDatabase.saveTaskList(_taskList, "taskList");
  }

  void search(String value, List<Task> taskListToSearch) {
    _searchTaskList.clear();
    for (Task item in taskListToSearch) {
      if (item.title.toLowerCase().contains(value.toLowerCase())) {
        _searchTaskList.add(item);
      }
    }
  }

  int getIDCount() {
    _idCount++;
    return _idCount;
  }
}
