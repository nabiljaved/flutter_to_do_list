import 'package:flutter/material.dart';
import 'package:todolist_app/services/category_service.dart';
import 'package:todolist_app/services/todo_service.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/models/todo.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  var _todoTitle = TextEditingController();
  var _todoDescription = TextEditingController();
  var _todoDate = TextEditingController();
  var _categories = List<DropdownMenuItem>();
  var _selectedValue;

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _showSnackBarMethod(message) {
    var _snackbar = new SnackBar(content: message);
    _scaffoldKey.currentState.showSnackBar(_snackbar);
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    //method to get categories
    var _categoryService = CategoryService();
    var categories = await _categoryService.getCategories();
    categories.forEach((result) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(result['name']),
          value: result['name'],
        ));
      });
    });
  }

  DateTime _date = DateTime.now();
  _selectTodoDate(BuildContext context) async {
    //select to do method
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2099));
    if (_pickedDate != null) {
      _date = _pickedDate;
      setState(() {
        _todoDate.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Create To do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  TextField(
                    controller: _todoTitle,
                    decoration: InputDecoration(
                        hintText: "To Do Title", labelText: "Cook Food"),
                  ),
                  TextField(
                    controller: _todoDescription,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: "To Do Description",
                        labelText: "Cook rice and Curry"),
                  ),
                  TextField(
                    controller: _todoDate,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: "YY-MM-DD",
                        labelText: "YY-MM-DD",
                        prefixIcon: InkWell(
                          onTap: () {
                            _selectTodoDate(context);
                          },
                          child: Icon(Icons.calendar_today),
                        )),
                  ),
                  DropdownButtonFormField(
                    value: _selectedValue,
                    items: _categories,
                    hint: Text("Save one category"),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                  RaisedButton(
                    onPressed: () async {
                      var model = Todo();
                      model.title = _todoTitle.text;
                      model.description = _todoDescription.text;
                      model.category = _selectedValue;
                      model.todoDate = _todoDate.text;
                      model.isFinished = 0;

                      if (_todoTitle.text == null ||
                          _todoDescription.text == null ||
                          _selectedValue == null ||
                          _todoDate.text == null) {
                        _showSnackBarMethod(Text("Please add values"));
                        FocusScope.of(context).requestFocus(FocusNode());
                        return;
                      }

                      var _todoService = TodoService();
                      var result = await _todoService.saveTodo(model);
                      FocusScope.of(context).requestFocus(FocusNode());
                      print(result);
                      if (result > 0) {
                        _showSnackBarMethod(Text("add is successfull"));
                      }
                    },
                    child: Text("Save"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
