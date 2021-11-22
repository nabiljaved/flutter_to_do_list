import 'package:todolist_app/models/todo.dart';
import 'package:todolist_app/repositories/repository.dart';

class TodoService {
  Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  saveTodo(Todo todo) async {
    return await _repository.save('todos', todo.todoMap());
  }

  getTodos() async {
    return await _repository.getAll('todos');
  }

  todosByCategory(String category) async {
    return await _repository.getByColumnName('todos', 'category', category);
  }
}
