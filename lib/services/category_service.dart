import 'package:budget/exceptions/service_expception.dart';
import 'package:budget/models/category.dart';
import 'package:budget/repository/category_repo.dart';
import 'package:budget/repository/firebase/category_repo.dart';

class CategoryService {
  static CategoryRepo categoryRepo = CategoryFirebaseRepo();

  static List<Category> categories = [];

  static Future<void> deleteCategory(String id) {
    return categoryRepo.deleteCategory(id);
  }

  static Future<void> saveCategory(Category category) {
    if (category.name.isEmpty) {
      throw ServiceException('Category name is mandatory');
    }

    if (category.id != null) {
      return categoryRepo.updateCategory(category).then((_) {
        getCategories();
      });
    }

    return categoryRepo.createCategory(category).then((_) {
      getCategories();
    });
  }

  static Future<List<Category>> getCategories() {
    return categoryRepo.getCategories().then((_categories) {
      return categories = _categories;
    });
  }

  static Category? getCategoryFromCache(String id) {
    List<Category> category =
        categories.where((element) => element.id == id).toList();
    return category.isEmpty ? null : category.first;
  }
}
