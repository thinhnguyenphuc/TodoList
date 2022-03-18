import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todolist/viewModels/HomeViewModel.dart';
import 'package:todolist/views/AddTaskScreen.dart';
import 'package:todolist/views/TaskViewItem.dart';

import '../models/Task.dart';
import '../notification/Notification.dart';
import '../resources/Strings.dart';
import '../resources/Nums.dart';
import '../widgets/CustomInputButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = HomeViewModel();
  bool _isSearch = false;
  bool _isTodayTask = false;
  bool _isUpcomingTask = false;
  bool _isDoneTask = false;
  double normalTextSize = 15;
  double chooseTextSize = 30;
  String lastSearchValue = "";
  Duration duration = const Duration(milliseconds: 100);
  Color textColor = Colors.green;
  TextEditingController searchController = TextEditingController();
  bool isHasNotification = false;
  Task? upcomingTask;

  void delete(Task task) {
    if (_isDoneTask) {
      _homeViewModel.deleteDoneTask(task);
    } else {
      _homeViewModel.deleteTask(task);
    }
    setState(() {});
  }

  void done(Task task) {
    _homeViewModel.addDoneTask(task);
    delete(task);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Insets insets = Insets.of(context);

    if(!_homeViewModel.isLoaded()){
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
        });
      });
    }

    final addButton = FloatingActionButton(
      elevation: 0.0,
      child: const Icon(Icons.add),
      backgroundColor: Colors.orange,
      onPressed: () {
        NotificationAPI.showNotification(
          title: "1",
          body: "1",
          payload: 'none',
        );
      },
    );

    void submit(String value, List<Task> taskListToSearch) {
      setState(() {
        lastSearchValue = value;
        value.isEmpty ? _isSearch = false : _isSearch = true;
        _homeViewModel.search(value, taskListToSearch);
      });
    }



    List<Task> getTaskList() {
      return _isTodayTask
          ? _homeViewModel.getTodayTaskList()
          : _isUpcomingTask
              ? _homeViewModel.getUpcomingTaskList()
              : _isDoneTask
                  ? _homeViewModel.getDoneTaskList()
                  : _homeViewModel.getTaskList();
    }
    if(isHasNotification){
      if(upcomingTask?.time.minute == DateTime.now().minute) {
        NotificationAPI.showNotification(
          title: upcomingTask?.title,
          body: upcomingTask?.description,
          payload: 'none',
        );
      }
    } else {
      if(upcomingTask == null){
        for(Task task in getTaskList()){
          if(task.time.subtract(const Duration(minutes: 10)).minute == DateTime.now().minute){
            isHasNotification = true;
            upcomingTask = task;
          }
        }
      } else {
        Future.delayed(const Duration(milliseconds: 60000), () {
          setState(() {
          });
        });
      }
    }


    Widget _allTask() {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemCount: getTaskList().length,
        itemBuilder: (BuildContext context, int index) {
          return TaskViewItem(
            isDone: _isDoneTask,
            task: getTaskList()[index],
            onDeleteClick: () => delete(getTaskList()[index]),
            onDoneClick: () => done(getTaskList()[index]),
          );
        },
      );
    }

    Widget _searchTask() {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemCount: _homeViewModel.getSearchTaskList().length,
        itemBuilder: (BuildContext context, int index) {
          return TaskViewItem(
            isDone: _isDoneTask,
            task: _homeViewModel.getSearchTaskList()[index],
            onDeleteClick: () => {
              _homeViewModel
                  .deleteTask(_homeViewModel.getSearchTaskList()[index]),
              setState(() {
                _homeViewModel.search(lastSearchValue, getTaskList());
              })
            },
            onDoneClick: () => done(_homeViewModel.getSearchTaskList()[index]),
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              )),
        ],
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: insets.large, horizontal: insets.large),
              child: InputFieldButton(
                controller: searchController,
                inputAction: TextInputAction.search,
                height: MediaQuery.of(context).size.longestSide / 20,
                onSubmitted: (String value) {
                  submit(value, getTaskList());
                },
                onChanged: (String value) {
                  submit(value, getTaskList());
                },
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    searchController.clear();
                  },
                ),
                hintText: Strings.searchTodoTask,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isTodayTask = false;
                      _isUpcomingTask = false;
                      _isDoneTask = false;
                      FocusScope.of(context).unfocus();
                      _homeViewModel.search(lastSearchValue, getTaskList());
                    });
                  },
                  child: AnimatedDefaultTextStyle(
                    duration: duration,
                    style: TextStyle(
                      fontSize:
                          !_isTodayTask && !_isUpcomingTask && !_isDoneTask
                              ? chooseTextSize
                              : normalTextSize,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(Strings.all),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isTodayTask = true;
                      _isUpcomingTask = false;
                      _isDoneTask = false;
                      FocusScope.of(context).unfocus();
                      _homeViewModel.search(lastSearchValue, getTaskList());
                    });
                  },
                  child: AnimatedDefaultTextStyle(
                    duration: duration,
                    style: TextStyle(
                      fontSize: _isTodayTask ? chooseTextSize : normalTextSize,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(Strings.today),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isTodayTask = false;
                      _isUpcomingTask = true;
                      _isDoneTask = false;
                      FocusScope.of(context).unfocus();
                      _homeViewModel.search(lastSearchValue, getTaskList());
                    });
                  },
                  child: AnimatedDefaultTextStyle(
                    duration: duration,
                    style: TextStyle(
                      fontSize:
                          _isUpcomingTask ? chooseTextSize : normalTextSize,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(Strings.upcoming),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isTodayTask = false;
                      _isUpcomingTask = false;
                      _isDoneTask = true;
                      FocusScope.of(context).unfocus();
                      _homeViewModel.search(lastSearchValue, getTaskList());
                    });
                  },
                  child: AnimatedDefaultTextStyle(
                    duration: duration,
                    style: TextStyle(
                      fontSize: _isDoneTask ? chooseTextSize : normalTextSize,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(Strings.done),
                  ),
                ),
              ],
            ),
            Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: _isSearch ? _searchTask() : _allTask(),
                )),
          ],
        ),
      ),
      floatingActionButton: addButton,
    );
  }
}
