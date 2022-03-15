import 'package:flutter/material.dart';

import '../models/Task.dart';
import 'package:intl/intl.dart';

class TaskViewItem extends StatelessWidget {
  TaskViewItem({
    required this.task,
    required this.onDeleteClick,
    required this.onDoneClick,
    required this.isDone,
  }) : super(key: ObjectKey(task));

  final Task task;
  final bool isDone;
  final VoidCallback onDeleteClick;
  final VoidCallback onDoneClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.shortestSide,
          height: MediaQuery.of(context).size.longestSide / 6,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.yellow, width: 0.75),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 1), // changes position of shadow
                )
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      onPressed: onDeleteClick, icon: const Icon(Icons.delete)),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                DateFormat("hh:mm a dd-MM-yyyy").format(task.time),
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 5),
              Text(
                task.description,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              if(!isDone) Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: TextButton(
                      onPressed: onDoneClick, child: const Text("Done")),
                ),
              ),
            ],
          ),
        ));
  }
}
