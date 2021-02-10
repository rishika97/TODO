import 'package:TODO/models/todo.dart';
import 'package:TODO/services/category_service.dart';
import 'package:TODO/services/todo_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitle = TextEditingController();
  var _todoDescription = TextEditingController();
  var _todoDate = TextEditingController();

  var _categories = List<DropdownMenuItem>();

  var _todo = Todo();
  var _todoService = TodoService();

  var _selectedValue;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _loadCategories()async{
    var _categoryService = CategoryService();
    var categories = await _categoryService.getCategories();
    categories.forEach((category){
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }



  DateTime _date = DateTime.now();

  _selectTodoDate(BuildContext context)async{
    var _pickDate = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2000), lastDate: DateTime(2099));
    if(_pickDate != null){
      setState(() {
        _date = _pickDate;
        _todoDate.text = DateFormat('yyyy-MM-dd').format(_pickDate);
      });
    }
  }

  _showSnackBar(message){
    var _snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Create TODO'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _todoTitle,
              decoration: InputDecoration(
                hintText: 'Todo Title',
                labelText: 'Todo Title'
              ),
            ),
            TextField(
              controller: _todoDescription,
              decoration: InputDecoration(
                  hintText: 'Todo Description',
                  labelText: 'Todo Description'
              ),
            ),
            TextField(
              controller: _todoDate,
              decoration: InputDecoration(
                hintText: 'YY-MM-DD',
                labelText: 'YY-MM-DD',
                prefixIcon: InkWell(
                  onTap: (){
                    _selectTodoDate(context);
                  },
                  child: Icon(
                    Icons.calendar_today,
                  ),
                ),
              ),
            ),
            DropdownButton(
              value: _selectedValue,
              items: _categories ,
              hint: Text('Select One Category'),
              onChanged: (value){
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            FlatButton(
              onPressed: ()async{
                _todo.title = _todoTitle.text;
                _todo.description = _todoDescription.text;
                _todo.category = _selectedValue.toString();
                _todo.todoDate = _todoDate.text;
                _todo.isFinished = 0;
                var result = await _todoService.saveTodo(_todo);
                if(result > 0){
                  _showSnackBar(Text('Success'));
                }
                print(result);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
