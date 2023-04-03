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
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Finished Tasks'),
      ),
      body: ListView(
        children: list.map((toDo) {
          return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 30,
                shadowColor: Colors.black,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: width,
                    minHeight: 100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 100,
                        ),
                        child: Transform.scale(
                          scale: 1.6,
                          child: Checkbox(
                              value: toDo.getComplete,
                              onChanged: ((_) async {
                                context
                                    .read<ToDoListProvider>()
                                    .setTaskUnfinish(toDo.getID);
                                Future.delayed(
                                    const Duration(milliseconds: 200), () {
                                  context
                                      .read<ToDoListProvider>()
                                      .transferUnfinished(toDo.getID);
                                });
                              })),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Container(
                        width: 80,
                        constraints: const BoxConstraints(
                          maxWidth: 80,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              toDo.item,
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            toDo.desc != ''
                                ? Text(
                                    toDo.desc,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
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
                ),
              ));
        }).toList(),
      ),
    );
  }
}
