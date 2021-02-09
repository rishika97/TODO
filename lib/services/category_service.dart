import 'package:TODO/models/category.dart';
import 'package:TODO/repositories/repository.dart';
import 'package:flutter/cupertino.dart';

class CategoryService {

  Repository _repository;

  CategoryService(){
    _repository = Repository();
  }

  saveCategory(Category category)async{
    return await _repository.save('categories', category.categoryMap());
  }

}