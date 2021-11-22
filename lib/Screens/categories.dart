import 'package:flutter/material.dart';
import 'package:todolist_app/Screens/home_screen.dart';
import 'package:todolist_app/models/category.dart';
import 'package:todolist_app/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryName = TextEditingController();
  var _categoryDescription = TextEditingController();
  var _category = new Category();
  var _categoryService = new CategoryService();

  //List<Widget> _categoryList = List<Widget>();
  List<Category> _categoryList = List<Category>();

  var _editcategoryName = TextEditingController();
  var _editcategoryDescription = TextEditingController();

  var category;

  @override
  void initState() {
    //when app run it first of all get all categories
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  getAllCategories() async //method to get all the categories
  {
    _categoryList = List<Category>();
    var categories = await _categoryService.getCategories();
    categories.forEach((result) {
      var model = Category();
      setState(() {
        //set state
        model.name = result['name'];
        model.id = result['id'];
        model.description = result['description'];
        _categoryList.add(model);
        print(result['name']);
      });
    });
  }

  //******************implementing alert dialog*************
  _showFormInDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  _category.name = _categoryName.text;
                  _category.description = _categoryDescription.text;
                  var result = await _categoryService
                      .saveCategory(_category); //save a category
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                    _showSnackBarMethod(Text("Add is successfull"));
                  }

                  print(result);
                },
                child: Text('Save'),
              )
            ],
            title: Center(child: Text('Category Form')),

            // *************textfield in scrollable********************
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    //textfield 1
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      hintText: 'write category name',
                    ),
                    controller: _categoryName,
                  ),
                  TextField(
                    //textfield 2
                    decoration: InputDecoration(
                        labelText: 'Category Description',
                        hintText: 'write description'),
                    controller: _categoryDescription,
                  )
                ],
              ),
            ),
          );
        });
  }

  //edit category dialog
  _editFormInDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  _category.id = category[0]['id'];
                  _category.name = _editcategoryName.text;
                  _category.description = _editcategoryDescription.text;
                  var result = await _categoryService
                      .updateCategory(_category); //edit a category
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                    _showSnackBarMethod(Text("update is successfull"));
                  }

                  print(result);
                },
                child: Text('Update'),
              )
            ],
            title: Center(
              child: Text('Category Edit Form'),
            ),

            // *************textfield in scrollable********************

            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    //textfield 3
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      hintText: 'write category name',
                    ),
                    controller: _editcategoryName,
                  ),
                  TextField(
                      //textfield 4
                      decoration: InputDecoration(
                          labelText: 'Category Description',
                          hintText: 'write description'),
                      controller: _editcategoryDescription)
                ],
              ),
            ),
          );
        });
  }

  //DELETE DIALOG

  //******************implementing alert dialog*************
  _deleteFormInDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.green,
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  var result =
                      await _categoryService.deleteCategory(categoryId);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                    _showSnackBarMethod(Text("Delete is successfull"));
                  }
                },
                color: Colors.red,
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
            title: Center(child: Text('Are you sure you want to delete?')),
          );
        });
  }

  _editCategory(BuildContext context, categoryId) async {
    //************get category by id*********

    category = await _categoryService.getCategoryById(categoryId);
    setState(() {
      _editcategoryName.text = category[0]['name'] ?? 'No Name';
      _editcategoryDescription.text =
          category[0]['description'] ?? 'No description';
    });

    _editFormInDialog(context);
  }

  _showSnackBarMethod(message) {
    var _snackbar = new SnackBar(content: message);
    _scaffoldKey.currentState.showSnackBar(_snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //***************SCAFFOLD************************
      key: _scaffoldKey,
      appBar: AppBar(
        leading: RaisedButton(
          elevation: 0.0,
          color: Colors.red,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), //when back arrow is pressed
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            ); //go back to previous screen
          },
        ),
        title: Text("categories"),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            //****build listview builder**
            return Card(
                child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editCategory(context, _categoryList[index].id);
                  //edit when pressed
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_categoryList[index].name),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteFormInDialog(
                          context, _categoryList[index].id); //add when clicked
                    },
                  )
                ],
              ),
            ));
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // call the alert dialog here
          _showFormInDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
