import 'package:flutter/material.dart';
import 'package:todolist_app/models/todo.dart';
import 'package:todolist_app/services/todo_service.dart';

class ToDoByCategory extends StatefulWidget {
  final String category;
  ToDoByCategory({this.category});

  @override
  _ToDoByCategoryState createState() => _ToDoByCategoryState();
}

class _ToDoByCategoryState extends State<ToDoByCategory> {
  List<Todo> _todoList = List<Todo>();
  TodoService _todoService = TodoService();

  @override
  initState() {
    super.initState();
    getToDoByCategory();
  }

  getToDoByCategory() async {
    var todos = await _todoService.todosByCategory(this.widget.category);
    todos.forEach((result) {
      setState(() {
        var model = Todo();
        model.title = result['title'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todos by category'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              this.widget.category,
              style: TextStyle(fontSize: 25, color: Colors.red),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        _todoList[index].title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
