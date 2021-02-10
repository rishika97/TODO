import 'package:TODO/helpers/drawer_navigation.dart';
import 'package:TODO/models/todo.dart';
import 'package:TODO/screens/todo_screen.dart';
import 'package:TODO/services/todo_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TodoService _todoService;
  List<Todo> _todoList = List<Todo>();


  @override
  void initState() {
    super.initState();
    getAllTodo();
  }

  getAllTodo()async{
    _todoService = TodoService();
    _todoList = List<Todo>();
    var todo = await _todoService.getTodo();
    todo.forEach((todo){
      var model = Todo();
      model.id = todo['id'];
      model.title = todo['title'];
      model.description = todo['description'];
      model.category = todo['category'];
      model.todoDate = todo['todoDate'];
      model.isFinished = todo['isFinished'];
      _todoList.add(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
        centerTitle: true,
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context,index){
            return Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_todoList[index].title ?? 'No Title'),
                  ],
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TodoScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
