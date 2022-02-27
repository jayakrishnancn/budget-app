import 'package:budget/models/category.dart';

abstract class CategoryRepo {
  Future<List<Category>> getCategories();
  Future<void> createCategory(Category category);
}
