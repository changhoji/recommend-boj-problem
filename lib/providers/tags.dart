import 'package:flutter/material.dart';
import 'package:whattosolve/models/solvedac_problem.dart';

class Tags with ChangeNotifier {
  List<Tag>? _tags;

  List<Tag>? get tags => _tags;

  set tags(List<Tag>? tags) {
    _tags = tags;
    notifyListeners();
  }
}
