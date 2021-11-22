class Category{

  int id;
  String name;
  String description;

  CategoryMap()
  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;

    return map;
  }
}