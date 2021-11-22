import 'package:flutter/material.dart';
import 'package:todolist_app/Helpers/drawer_navigations.dart';
import 'package:todolist_app/Screens/todo_screen.dart';
import 'package:todolist_app/services/todo_service.dart';
import 'package:todolist_app/models/todo.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService = TodoService();
  List<Todo> _todolist = [];

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todolist = [];
    var todos = await _todoService.getTodos();
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todolist.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List App"),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
        itemCount: _todolist.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.ac_unit),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(_todolist[index].title),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Nabeel Javed"),
                      Icon(
                        Icons.access_time_sharp,
                        color: Colors.amber,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ToDoScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
