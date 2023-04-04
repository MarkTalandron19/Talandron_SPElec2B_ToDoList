import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talandron_spelec2b_todolist/providers/todolistprovider.dart';
import 'package:talandron_spelec2b_todolist/widgets/homepage.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ToDoListProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
