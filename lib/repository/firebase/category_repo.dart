import 'package:budget/models/category.dart';
import 'package:budget/repository/category_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryFirebaseRepo extends CategoryRepo {
  final String userid = 'jayakrishnancn@gmail.com';

  CollectionReference<Map<String, dynamic>> get root =>
      FirebaseFirestore.instance.collection('users/$userid/categories');

  @override
  Future<List<Category>> getCategories() async {
    List<Category> categories = [];

    final querySnapshot = await root.get();
    for (var map in querySnapshot.docs) {
      categories.add(Category.fromMap(map.data(), map.id));
    }

    return categories;
  }

  @override
  Future<void> createCategory(Category category) {
    return root.add(category.toMap());
  }
}
