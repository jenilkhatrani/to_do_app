import 'package:flutter/foundation.dart';

class Todo {
  final String name;
  bool done;

  Todo({
    required this.name,
    this.done = false,
  });
}

class ToDoViewModel extends ChangeNotifier {
  final List<Todo> toDoList = [];

  void addToDo(String name) {
    toDoList.add(Todo(name: name));
    notifyListeners();
  }

  void deleteToDo(int index) {
    toDoList.removeAt(index);
    notifyListeners();
  }

  void toggleCompletion(int index) {
    toDoList[index].done = !toDoList[index].done;
    notifyListeners();
  }
}
