import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProblem {
  final int level;
  final String titleKo;
  final Timestamp timestamp;
  final List<dynamic> tags;

  FirestoreProblem({
    required this.level,
    required this.titleKo,
    required this.timestamp,
    required this.tags,
  });

  factory FirestoreProblem.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return FirestoreProblem(
      level: data['level'],
      titleKo: data['titleKo'],
      timestamp: data['timestamp'],
      tags: data['tags'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'level': level,
      'titleKo': titleKo,
      'timestamp': timestamp,
      'tags': tags,
    };
  }
}
