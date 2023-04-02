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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Finish')
        ],
      ),
    );
  }
}
