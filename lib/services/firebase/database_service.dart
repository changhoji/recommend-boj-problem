import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static Future<String> linkedHandle(String uid) async {
    final ref = FirebaseDatabase.instance.ref("users/$uid");
    final snapshot = await ref.child("handle").get();

    if (snapshot.exists) {
      return snapshot.toString();
    }
    return "";
  }

  static void test(String uid, String message) async {
    final ref = FirebaseDatabase.instance.ref("users/$uid");
    await ref.set({
      "handle": "changhoji",
    });
  }
}
