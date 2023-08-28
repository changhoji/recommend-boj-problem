import 'package:flutter/material.dart';
import 'package:whattosolve/models/solvedac_problem.dart';

class Filter with ChangeNotifier {
  String _level = "b5..r1";
  String _handle = "";
  SolvedacProblem? _suggestion;
  final List<Tag> _tags = <Tag>[];
  bool _translated = false;
  bool _searched = false;

  String get level => _level;
  String get handle => _handle;
  SolvedacProblem? get suggestion => _suggestion;
  List<Tag> get tags => _tags;
  bool get translated => _translated;
  bool get searched => _searched;

  set level(String level) {
    _level = level;
    _searched = !_searched;
    notifyListeners();
  }

  set handle(String handle) {
    _handle = handle;
    _searched = !_searched;
    notifyListeners();
  }

  set suggestion(SolvedacProblem? suggestion) {
    _suggestion = suggestion;
    notifyListeners();
  }

  set searched(bool searched) {
    _searched = searched;
    notifyListeners();
  }

  void reverseTranslated() {
    _translated = !_translated;
    _searched = !_searched;
    notifyListeners();
  }

  void addTag(Tag tag) {
    if (_tags.contains(tag)) return;
    _tags.add(tag);
    _searched = !_searched;
    notifyListeners();
  }

  void removeTag(Tag tag) {
    if (!_tags.contains(tag)) return;
    _tags.remove(tag);
    _searched = !_searched;
    notifyListeners();
  }
}
