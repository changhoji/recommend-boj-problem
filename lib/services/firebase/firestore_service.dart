import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whattosolve/providers/search_filter.dart';

class FirestoreService {
  static final db = FirebaseFirestore.instance;

  static void saveFilter(String uid, SearchFilter filter, String? fid) {
    db
        .collection("users")
        .doc(uid)
        .collection("filters")
        .doc(fid)
        .set(filter.toMap());
  }
}
