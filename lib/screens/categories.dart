import 'package:flutter/material.dart';
import 'package:to_do/models/category_model.dart';
import 'package:to_do/screens/home.dart';
import 'package:to_do/services/category_service.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  TextEditingController _categoryName = TextEditingController();
  TextEditingController _categoryDescription = TextEditingController();
  var _category = Category();
  var _categoryService = CategoryService();
  List<Category> _categoryList = List<Category>();

  var _editCategoryName = TextEditingController();

  var _editCategoryDescription = TextEditingController();

  var category;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _showSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: RaisedButton(
          color: Colors.red,
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Home())),
        ),
        title: Text('To Do App'),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                key: ObjectKey(index),
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editCategory(context, _categoryList[index].id);
                  },
                ),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_categoryList[index].name),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteCategoryDialog(
                                context, _categoryList[index].id);
                          })
                    ]),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showFormInDialog(context),
      ),
    );
  }

  _showFormInDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  _category.name = _categoryName.text;
                  _category.description = _categoryDescription.text;
                  var result = await _categoryService.saveCategory(_category);
                  if (result > 0) {
                    Navigator.pop(context);
                    _showSnackBar(Text('Data has been added'));
                    getAllCategories();
                  }
                },
                child: Text('Save'),
              ),
            ],
            title: Text('Category Form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryName,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      hintText: 'Write category name',
                    ),
                  ),
                  TextField(
                    controller: _categoryDescription,
                    decoration: InputDecoration(
                      labelText: 'Category Description',
                      hintText: 'Write category description',
                    ),
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
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  _category.id = category[0]['id'];
                  _category.name = _editCategoryName.text;
                  _category.description = _editCategoryDescription.text;
                  var result = await _categoryService.updateCategory(_category);
                  if (result > 0) {
                    Navigator.pop(context);
                    _showSnackBar(Text('Data has been updated'));
                    getAllCategories();
                  }
                },
                child: Text('Update'),
              ),
            ],
            title: Text('Category Edit Form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editCategoryName,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      hintText: 'Write category name',
                    ),
                  ),
                  TextField(
                    controller: _editCategoryDescription,
                    decoration: InputDecoration(
                      labelText: 'Category Description',
                      hintText: 'Write category description',
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.getCategoryById(categoryId);
    setState(() {
      _editCategoryName.text = category[0]['name'] ?? '';
      _editCategoryDescription.text = category[0]['description'] ?? '';
    });
    _editCategoryDialog(context);
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.getCategories();

    categories.forEach((category) {
      setState(() {
        var model = Category();
        model.name = category['name'];
        model.id = category['id'];
        model.description = category['description'];
        _categoryList.add(model);
      });
    });
  }

  _deleteCategoryDialog(BuildContext context, categoryId) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                color: Colors.red,
                onPressed: () async {
                  print(_categoryList.length);
                  var result =
                      await _categoryService.deleteCategory(categoryId);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                    _showSnackBar(Text('Data has been deleted.'));
                  } else {
                    Navigator.pop(context);
                    getAllCategories();
                    _showSnackBar(Text('Data has not been deleted.'));
                  }
                },
                child: Text('Delete'),
              ),
            ],
            title: Text('Are you sure to delete?'),
          );
        });
  }
}
