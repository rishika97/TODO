import 'package:TODO/models/todo.dart';
import 'package:TODO/repositories/repository.dart';

class TodoService{
  Repository _repository;

  TodoService(){
    _repository = Repository();
  }

  saveTodo(Todo todo)async{
    return await _repository.save('todo', todo.todoMap());
  }

  getTodo()async{
    return await _repository.getAll('todo');
  }

  todoByCategory(String category)async{
    return await _repository.getByColumnName('todo','category',category);
  }
}