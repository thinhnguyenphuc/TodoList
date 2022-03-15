import 'package:flutter/material.dart';

import '../models/Task.dart';

class HomeViewModel with ChangeNotifier {
  static final List<Task> _taskList = [];
  static final List<Task> _searchTaskList = [];
  static final List<Task> _todayTaskList = [];
  static final List<Task> _upcomingTaskList = [];
  static final List<Task> _doneTaskList = [];
  static int _idCount = 0;

  HomeViewModel(){
    _initTodayList();
    _initUpComingList();
  }

  void _initTodayList(){
    _todayTaskList.clear();
    for (Task task in _taskList){
      if(task.time.day == DateTime.now().day){
        _todayTaskList.add(task);
      }
    }
  }

  void _initUpComingList(){
    _upcomingTaskList.clear();
    for (Task task in _taskList){
      if(task.time.day == DateTime.now().day+1){
        _upcomingTaskList.add(task);
      }
    }
  }

  void addTask(Task task) {
    _taskList.add(task);
    _initTodayList();
    _initUpComingList();
  }

  void addDoneTask(Task task){
    _doneTaskList.add(task);
  }

  void deleteDoneTask(Task task){
    for (Task item in _doneTaskList) {
      if (item.id == task.id) {
        _doneTaskList.remove(item);
        break;
      }
    }
  }

  List<Task> getTaskList() {
    return _taskList;
  }

  List<Task> getTodayTaskList(){
    return _todayTaskList;
  }

  List<Task> getUpcomingTaskList(){
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
