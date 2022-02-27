import 'package:budget/enums/routes.dart';
import 'package:budget/models/category.dart';
import 'package:budget/services/category_service.dart';
import 'package:budget/utils/color.dart';
import 'package:budget/widgets/body_wrapper.dart';
import 'package:budget/widgets/j_alertbox.dart';
import 'package:flutter/material.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({Key? key}) : super(key: key);

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  Future<List<Category>> _futureCategories = CategoryService.getCategories();

  @override
  Widget build(BuildContext context) {
    final bool _selectionMode =
        (ModalRoute.of(context)?.settings.arguments ?? false) as bool;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addCategory.name).then((value) {
            setState(() {
              _futureCategories = CategoryService.getCategories();
            });
          });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _futureCategories,
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapShot.hasError || snapShot.data == null) {
            return JAlertBox(title: snapShot.error.toString());
          }

          List<Category> categories = snapShot.data as List<Category>;
          categories.sort((a, b) => a.name.compareTo(b.name));
          return BodyWrapper(
            enableSingleChildScrollView: false,
            child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (ctx, index) {
                  Category category = categories[index];
                  return ListTile(
                      onTap: () {
                        if (_selectionMode) {
                          Navigator.pop(context, category);
                        }
                      },
                      title: Text(category.name),
                      leading: InkWell(
                        child: CircleAvatar(
                            child: CircleAvatar(
                          child: Icon(
                            category.icon,
                            color: getAltColor(category.color),
                          ),
                          backgroundColor: category.color,
                        )),
                      ));
                }),
          );
        },
      ),
    );
  }
}
