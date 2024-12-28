import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/view_model/to_do_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final toDoViewModel = Provider.of<ToDoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'To-Do',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: toDoViewModel.toDoList.isEmpty
          ? const Center(
        child: Text("No Data Available"),
      )
          : ListView.builder(
        itemCount: toDoViewModel.toDoList.length,
        itemBuilder: (context, index) {
          final toDo = toDoViewModel.toDoList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Checkbox(
                  value: toDo.done,
                  onChanged: (value) {
                    toDoViewModel.toggleCompletion(index);
                  },
                ),
                title: Text(
                  toDo.name,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    toDoViewModel.deleteToDo(index);
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formKey = GlobalKey<FormState>();
          String? title;

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add To-Do'),
                content: Form(
                  key: formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a to-do item.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      title = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'To-Do Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (title != null) {
                          Provider.of<ToDoViewModel>(context, listen: false)
                              .addToDo(title!);
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      ),
    );
  }
}
