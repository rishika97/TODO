import 'package:TODO/models/todo.dart';
import 'package:TODO/services/todo_service.dart';
import 'package:flutter/material.dart';

class TodoByCategory extends StatefulWidget {
  final String category;
  TodoByCategory({this.category});

  @override
  _TodoByCategoryState createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  List<Todo> _todoList = List<Todo>();
  TodoService _todoService = TodoService();

  getTodoByCategory() async {
    var todo = _todoService.todoByCategory(this.widget.category);
    todo.forEach((todo) {
      setState(() {
        var model = Todo();
        model.title = todo['title'];
        _todoList.add(model);
      });
    });
  }


  @override
  void initState() {
    super.initState();
    getTodoByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo By Category'),
      ),
      body: Column(
        children: <Widget>[
          Text(this.widget.category),
          Expanded(
            child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return Text(_todoList[index].title);
                }),
          ),
        ],
      ),
    );
  }
}
