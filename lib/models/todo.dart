import 'package:uuid/uuid.dart';

class ToDo {
  String toDo;
  String description;
  bool completed;
  final String id;

  ToDo({required this.toDo, required this.description})
      : id = const Uuid().v4(),
        completed = false;

  String get item => toDo;
  String get desc => description;
  String get getID => id;
  bool get getComplete => completed;

  set setToDo(String item) {
    toDo = item;
  }

  set setDesc(String desc) {
    description = desc;
  }

  void setCompleted() {
    completed = !completed;
  }
}
