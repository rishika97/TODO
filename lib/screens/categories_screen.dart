import 'package:TODO/models/category.dart';
import 'package:TODO/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:TODO/screens/home_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  var _categoryName = TextEditingController();
  var _categoryDescription = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  _showDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param){
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  onPressed: ()async{
                    _category.name = _categoryName.text;
                    _category.description = _categoryDescription.text;
                    var result = await _categoryService.saveCategory(_category);
                    print(result);
                  },
                  child: Text('Save'),
              ),
              FlatButton(
                  onPressed: (){

                  },
                  child: Text('Cancel'),
              ),
            ],
            title: Text(
              'Category Form'
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryName,
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      hintText: 'Write Category Name'
                    ),
                  ),
                  TextField(
                    controller: _categoryDescription,
                    decoration: InputDecoration(
                        labelText: 'Category Description',
                        hintText: 'Write Category Description'
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(
          elevation: 0.0,
          color: Colors.red,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new HomeScreen()));
          },
        ),
        title: Text('TODO'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Category'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
