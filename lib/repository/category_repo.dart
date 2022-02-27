import 'package:budget/models/category.dart';

abstract class CategoryRepo {
  Future<List<Category>> getCategories();
  Future<void> createCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String id);
}
