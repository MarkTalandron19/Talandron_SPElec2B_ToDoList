import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talandron_spelec2b_todolist/providers/todolistprovider.dart';
import 'package:talandron_spelec2b_todolist/widgets/finishlistwidget.dart';
import 'package:talandron_spelec2b_todolist/widgets/todolistwidget.dart';

import '../models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currrentIndex = 0;
  final pages = [
    Center(
      child: Consumer<ToDoListProvider>(
        builder: (context, value, child) {
          return ToDoListWidget(
            list: value.list,
          );
        },
      ),
    ),
    Center(
      child: Consumer<ToDoListProvider>(
        builder: (context, value, child) {
          return FinishListWidget(
            list: value.completed,
          );
        },
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currrentIndex,
        onTap: (index) => setState(() {
          currrentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist_outlined), label: 'Todos'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Completed')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItem(context);
        },
        child: const Icon(Icons.add),
      ),
    );
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
                      hintText: 'Input To Do item here',
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
                      const snackBar =
                          SnackBar(content: Text('To Do Item added'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
}
