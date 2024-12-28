class ToDoModel {
  int? id;
  String name;
  int done;

  ToDoModel({
    this.id,
    required this.name,
    required this.done,
  });

  factory ToDoModel.fromMap({required Map data}) {
    return ToDoModel(
      id: data['id'],
      name: data['name'],
      done: data['done'] ?? 0,
    );
  }
}