import 'package:budget/exceptions/service_expception.dart';
import 'package:budget/models/category.dart';
import 'package:budget/repository/category_repo.dart';
import 'package:budget/repository/firebase/category_repo.dart';

class CategoryService {
  static CategoryRepo categoryRepo = CategoryFirebaseRepo();
  static Future<void> saveCategory(Category category) {
    if (category.name.isEmpty) {
      throw ServiceException('Category name is mandatory');
    }
    return categoryRepo.createCategory(category);
  }

  static Future<List<Category>> getCategories() {
    return categoryRepo.getCategories();
  }
}
