import 'package:cloud_firestore/cloud_firestore.dart';

class SolvedacProblem {
  late int problemId;
  late String titleKo;
  late int level;
  List<Tag> tags = <Tag>[];

  SolvedacProblem.fromJson(Map<String, dynamic> json) {
    problemId = json['problemId'];
    titleKo = json['titleKo'];
    level = json['level'];

    json['tags'].forEach((tag) {
      tags.add(Tag.fromJson(tag));
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'titleKo': titleKo,
      'level': level,
      'tags': tags.map((tag) => tag.displayName).toList(),
      'timestamp': Timestamp.now(),
    };
  }
}

class Tag {
  late String key;
  late int bojTagId;
  late String displayName;

  Tag.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    bojTagId = json['bojTagId'];
    displayName = json['displayNames'][0]['name'];
  }

  @override
  int get hashCode => bojTagId;

  @override
  bool operator ==(covariant Tag other) {
    return bojTagId == other.bojTagId;
  }
}
