import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/todo.dart';
import 'package:provider/provider.dart';

import '../providers/todolistprovider.dart';

class ToDoListWidget extends StatelessWidget {
  final UnmodifiableListView<ToDo> list;

  const ToDoListWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('To Do List'),
      ),
      body: ListView(
        children: list.map((toDo) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                      onPressed: (context) {
                        editItem(context, toDo);
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit'),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                      onPressed: (context) {
                        context.read<ToDoListProvider>().remove(toDo.getID);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete'),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  editItem(context, toDo);
                },
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
                                      .setTaskComplete(toDo.getID);
                                  Future.delayed(
                                      const Duration(milliseconds: 200), () {
                                    context
                                        .read<ToDoListProvider>()
                                        .transferCompleted(toDo.getID);
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
                ),
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItem(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> addItem(BuildContext context) async {
  TextEditingController controller = TextEditingController();
  TextEditingController descController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            'Add new to do item',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          content: SizedBox(
            height: 150,
            width: 500,
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Input Here',
                  ),
                ),
                const Spacer(),
                TextField(
                  controller: descController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Input Description',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    final newItem = ToDo(
                        toDo: controller.text,
                        description: descController.text);
                    context.read<ToDoListProvider>().add(newItem);
                    controller.clear();
                    descController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Enter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                )),
          ],
        );
      });
}

Future<void> editItem(BuildContext context, ToDo toDo) async {
  TextEditingController editController = TextEditingController();
  TextEditingController editDescController = TextEditingController();
  editController.text = toDo.item;
  editDescController.text = toDo.desc;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            'Edit to do item',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          content: SizedBox(
            height: 150,
            width: 500,
            child: Column(
              children: [
                TextField(
                  controller: editController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Edit Here',
                  ),
                ),
                const Spacer(),
                TextField(
                  controller: editDescController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Edit Description',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (editController.text.isNotEmpty) {
                    final edit = editController.text;
                    final descEdit = editDescController.text;
                    context
                        .read<ToDoListProvider>()
                        .edit(toDo.getID, edit, descEdit);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Enter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                )),
          ],
        );
      });
}
