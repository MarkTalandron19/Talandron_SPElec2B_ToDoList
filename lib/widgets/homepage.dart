import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talandron_spelec2b_todolist/providers/todolistprovider.dart';
import 'package:talandron_spelec2b_todolist/widgets/todolistwidget.dart';

import '../models/todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('To Do List'),
      ),
      body: Center(child: Consumer<ToDoListProvider>(
        builder: (context, value, child) {
          return ToDoListWidget(
            list: value.list,
          );
        },
      )),
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
            width: 500,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Input Here',
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    final newItem = ToDo(toDo: controller.text);
                    context.read<ToDoListProvider>().add(newItem);
                    controller.clear();
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
