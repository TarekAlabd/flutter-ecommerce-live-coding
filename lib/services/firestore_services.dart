import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class FirestoreServices {
  FirestoreServices._(); //PRIVATE CONSTRACTOR,CAN'T CREATE OBJ FROM THIS CLASS TYPE OUTSIDE
  static final instance = FirestoreServices._();
  final _firestore = FirebaseFirestore.instance;
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final refrence = _firestore.doc(path);
    debugPrint('SetData => Request Data : $data');
    await refrence.set(data); //for both of operations : add and update
  }

  Future<void> deleteData({
    required String path,
  }) async {
    final refrence = _firestore.doc(path);
    debugPrint('deleteData => Path to delete : $path');
    await refrence.delete();
  }

  Stream<T> documentsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documnenId) builder,
  }) {
    final refrence = _firestore.doc(path);
    final snapShots = refrence.snapshots();
    return snapShots.map((snapShot) => builder(snapShot.data(), snapShot.id));
  }

   Stream<List<T>> collectionsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) => builder(
              snapshot.data() as Map<String, dynamic>,
              snapshot.id,
            ),
          )
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}
