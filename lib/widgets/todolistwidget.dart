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
    return ListView(
      children: list.map((toDo) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                      value: toDo.getComplete,
                      onChanged: ((_) => context
                          .read<ToDoListProvider>()
                          .taskComplete(toDo.getID))),
                  SizedBox(
                    width: 200,
                    child: Text(
                      toDo.item,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

Future<void> editItem(BuildContext context, ToDo toDo) async {
  TextEditingController editController = TextEditingController();
  editController.text = toDo.item;
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
            width: 500,
            child: TextField(
              controller: editController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Input Here',
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (editController.text.isNotEmpty) {
                    final edit = editController.text;
                    context.read<ToDoListProvider>().edit(toDo.getID, edit);
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
