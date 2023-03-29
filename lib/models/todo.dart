import 'package:uuid/uuid.dart';

class ToDo {
  String toDo;
  bool completed;
  final String id;

  ToDo({required this.toDo})
      : id = const Uuid().v4(),
        completed = false;

  String get item => toDo;
  String get getID => id;
  bool get getComplete => completed;

  set setToDo(String item) {
    toDo = item;
  }

  void setCompleted() {
    completed = !completed;
  }
}
