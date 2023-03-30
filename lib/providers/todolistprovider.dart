import 'dart:collection';

import 'package:flutter/material.dart';
import '../models/todo.dart';

class ToDoListProvider extends ChangeNotifier {
  final List<ToDo> _list = [];
  final List<ToDo> _completed = [];

  UnmodifiableListView<ToDo> get list => UnmodifiableListView(_list);
  UnmodifiableListView<ToDo> get completed => UnmodifiableListView(_completed);

  void add(ToDo item) {
    _list.add(item);
    notifyListeners();
  }

  void edit(String id, String edit, String descEdit) {
    int index = _list.indexWhere((e) => e.getID == id);
    _list[index].setToDo = edit;
    _list[index].setDesc = descEdit;
    notifyListeners();
  }

  void remove(String id) {
    int index = _list.indexWhere((e) => e.getID == id);
    _list.removeAt(index);
    notifyListeners();
  }

  void taskComplete(String id) {
    int index = _list.indexWhere((e) => e.getID == id);
    _list[index].setCompleted();
    notifyListeners();
  }
}
