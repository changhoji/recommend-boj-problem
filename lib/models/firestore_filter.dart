import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFilter {
  final String filterName;
  final String handle;
  final int levelStart;
  final int levelEnd;
  final bool translated;
  final List<dynamic> containTags;
  final List<dynamic> exceptTags;

  FirestoreFilter({
    required this.filterName,
    required this.handle,
    required this.levelStart,
    required this.levelEnd,
    required this.translated,
    required this.containTags,
    required this.exceptTags,
  });

  factory FirestoreFilter.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return FirestoreFilter(
      filterName: data['filterName'],
      handle: data['handle'],
      levelStart: data['levelStart'],
      levelEnd: data['levelEnd'],
      translated: data['translated'],
      containTags: data['containTags'],
      exceptTags: data['exceptTags'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'filterName': filterName,
      'handle': handle,
      'levelStart': levelStart,
      'levelEnd': levelEnd,
      'translated': translated,
      'containTags': containTags,
      'exceptTags': exceptTags,
    };
  }
}
