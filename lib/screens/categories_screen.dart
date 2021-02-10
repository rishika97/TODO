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

  List<Category> _categoryList = List<Category>();

  var _editCategoryName = TextEditingController();
  var _editCategoryDescription = TextEditingController();

  var category;

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.getCategories();
    categories.forEach((category) {
      setState(() {
        var model = Category();
        model.id = category['id'];
        model.name = category['name'];
        model.description = category['description'];
        _categoryList.add(model);
      });
    });
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  _category.name = _categoryName.text;
                  _category.description = _categoryDescription.text;
                  var result = await _categoryService.saveCategory(_category);
                  if(result > 0){
                    Navigator.pop(context);
                    _showSnackBar(Text('Data Saved Successfully'));
                  }
                  print(result);
                },
                child: Text('Save'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
            title: Text('Category Form'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryName,
                    decoration: InputDecoration(
                        labelText: 'Category Name',
                        hintText: 'Write Category Name'),
                  ),
                  TextField(
                    controller: _categoryDescription,
                    decoration: InputDecoration(
                        labelText: 'Category Description',
                        hintText: 'Write Category Description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _editCategoryDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  _category.id = category[0]['id'];
                  _category.name = _editCategoryName.text;
                  _category.description = _editCategoryDescription.text;
                  var result = await _categoryService.updateCategory(_category);
                  if(result > 0){
                    Navigator.pop(context);
                    getAllCategories();
                    _showSnackBar(Text('Data Updated Successfully'));
                  }
                  print(result);
                },
                child: Text('Update'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
            title: Text('Category Edit Form'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editCategoryName,
                    decoration: InputDecoration(
                        labelText: 'Category Name',
                        hintText: 'Edit Category Name'),
                  ),
                  TextField(
                    controller: _editCategoryDescription,
                    decoration: InputDecoration(
                        labelText: 'Category Description',
                        hintText: 'Edit Category Description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _deleteCategoryDialog(BuildContext context,categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  var result = await _categoryService.deleteCategory(categoryId);
                  if(result > 0){
                    Navigator.pop(context);
                    getAllCategories();
                    _showSnackBar(Text('Data Deleted Successfully'));
                  }
                  print(result);
                },
                color: Colors.redAccent,
                child: Text('Delete',style: TextStyle(color: Colors.white),),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.greenAccent,
                child: Text('Cancel',style: TextStyle(color: Colors.white),),
              ),
            ],
            title: Text('Are You Sure, You Want To Delete The Data?'),
          );
        });
  }

  _editCategory(BuildContext context,categoryId)async{
    category = await _categoryService.getCategoryById(categoryId);
    setState(() {
      _editCategoryName.text = category[0]['name'] ?? 'No Name';
      _editCategoryDescription.text = category[0]['description' ?? 'No Description'];
    });
    _editCategoryDialog(context);
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
        leading: RaisedButton(
          elevation: 0.0,
          color: Colors.red,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new HomeScreen()));
          },
        ),
        title: Text('TODO'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context,index){
            return Card(
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editCategory(context, _categoryList[index].id);
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_categoryList[index].name),
                    IconButton(icon: Icon(Icons.delete), onPressed: () {
                      _deleteCategoryDialog(context, _categoryList[index].id);
                    }),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
