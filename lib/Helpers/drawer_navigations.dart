import 'package:flutter/material.dart';
import 'package:todolist_app/Screens/About.dart';
import 'package:todolist_app/Screens/home_screen.dart';
import 'package:todolist_app/Screens/categories.dart';
import 'package:todolist_app/services/category_service.dart';
import 'package:todolist_app/Screens/todo_by_category.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DrawerNavigationState();
  }
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = List<Widget>();
  CategoryService _categoryService = CategoryService();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  //method to get all categories
  getAllCategories() async {
    var categories = await _categoryService.getCategories();
    categories.forEach(
      (result) {
        setState(() {
          _categoryList.add(
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ToDoByCategory(
                      category: result['name'],
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(result['name']),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            //***********drawer header*****************
            UserAccountsDrawerHeader(
              accountName: Text("To Do App"),
              accountEmail: Text("Category & priority based to do app"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.red),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            Divider(),
            ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.view_list),
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (context) => CategoriesScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('About'),
              leading: Icon(Icons.assignment_ind),
              onTap: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) => App()));
              },
            ),
            Divider(),
            Column(
              children: _categoryList,
            )
          ],
        ),
      ),
    );
  }
}
