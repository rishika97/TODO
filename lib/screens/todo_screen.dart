import 'package:TODO/services/category_service.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitle = TextEditingController();
  var _todoDescription = TextEditingController();
  var _todoDate = TextEditingController();

  var _categories = List<DropdownMenuItem>();

  var _selectedValue;


  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories()async{
    var _categoryService = CategoryService();
    var categories = await _categoryService.getCategories();
    categories.forEach((catgory){
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(catgory['name']),
          value: catgory['name'],
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create TODO'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _todoTitle,
            decoration: InputDecoration(
              hintText: 'Todo Title',
              labelText: 'Cook Food'
            ),
          ),
          TextField(
            controller: _todoDescription,
            decoration: InputDecoration(
                hintText: 'Todo Description',
                labelText: 'Cook rice and curry'
            ),
          ),
          TextField(
            controller: _todoDate,
            decoration: InputDecoration(
              hintText: 'YY-MM-DD',
              labelText: 'YY-MM-DD',
              prefixIcon: Icon(Icons.calendar_today)
            ),
          ),
          DropdownButton(
            value: _selectedValue,
            items: _categories ,
            hint: Text('Select One Category'),
            onChanged: (value){
              _selectedValue = value;
            },
          ),
          RaisedButton(
              onPressed: null
          ),
        ],
      ),
    );
  }
}
