import 'package:todolist_app/models/category.dart';
import 'package:todolist_app/repositories/repository.dart';

class CategoryService{

  Repository _respository;

  CategoryService()
  {
    _respository = new Repository();
  }

  saveCategory(Category category) async
  {
    return await _respository.save('categories', category.CategoryMap());
  }

  getCategories() async{
    return await _respository.getAll("categories");
  }

  getCategoryById(categoryId) async{
    return await _respository.getById('categories', categoryId);
  }

  updateCategory(Category category) async{
      return await _respository.update('categories', category.CategoryMap());
  }

  deleteCategory(categoryId) async{
    return await _respository.delete('categories', categoryId);
  }

}