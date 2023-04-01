import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todolistprovider.dart';

class FinishListWidget extends StatelessWidget {
  final UnmodifiableListView<ToDo> list;

  const FinishListWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list.map((toDo) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Checkbox(
                  value: toDo.getComplete,
                  onChanged: ((_) async {
                    context
                        .read<ToDoListProvider>()
                        .setTaskUnfinish(toDo.getID);
                    Future.delayed(const Duration(milliseconds: 200), () {
                      context
                          .read<ToDoListProvider>()
                          .transferUnfinished(toDo.getID);
                    });
                  })),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toDo.item,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 28,
                      ),
                    ),
                    toDo.desc != ''
                        ? Text(
                            toDo.desc,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 28,
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
