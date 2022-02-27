import 'package:budget/exceptions/service_expception.dart';
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

  @override
  Future<void> deleteCategory(String id) {
    var docRef = root.doc(id);

    return docRef.get().then((doc) {
      if (doc.exists) {
        return docRef.delete();
      }
      return Future.error('category does not exist.');
    }).catchError((error) {
      throw ServiceException('Cant find category');
    });
  }

  @override
  Future<void> updateCategory(Category category) {
    if (category.id == null) {
      Future.error('category does not exist.');
    }

    var docRef = root.doc(category.id);

    return docRef.get().then((doc) {
      if (doc.exists) {
        return docRef.set(category.toMap());
      }
      return Future.error('category does not exist.');
    }).catchError((error) {
      throw ServiceException('Cant find category');
    });
  }
}
