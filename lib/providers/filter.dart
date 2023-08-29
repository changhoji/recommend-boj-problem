import 'package:flutter/material.dart';
import 'package:whattosolve/models/solvedac_problem.dart';

class Filter with ChangeNotifier {
  RangeValues _level = const RangeValues(1, 30);
  String _handle = "";
  SolvedacProblem? _suggestion;
  bool _translated = false;
  bool _searched = false;
  final List<Tag> _containTags = <Tag>[];
  final List<Tag> _exceptTags = <Tag>[];

  RangeValues get level => _level;
  String get handle => _handle;
  SolvedacProblem? get suggestion => _suggestion;
  bool get translated => _translated;
  bool get searched => _searched;
  List<Tag> get containTags => _containTags;
  List<Tag> get exceptTags => _exceptTags;

  set level(RangeValues level) {
    _level = level;
    _searched = false;
    notifyListeners();
  }

  set handle(String handle) {
    _handle = handle;
    _searched = false;
    notifyListeners();
  }

  set suggestion(SolvedacProblem? suggestion) {
    _suggestion = suggestion;
    notifyListeners();
  }

  void reverseTranslated() {
    _translated = !_translated;
    _searched = false;
    notifyListeners();
  }

  set searched(bool searched) {
    _searched = searched;
    notifyListeners();
  }

  void addContainTag(Tag tag) {
    if (_containTags.contains(tag) || _exceptTags.contains(tag)) return;
    _containTags.add(tag);
    _searched = false;
    notifyListeners();
  }

  void removeContainTag(Tag tag) {
    if (!_containTags.contains(tag)) return;
    _containTags.remove(tag);
    _searched = false;
    notifyListeners();
  }

  void addExceptTag(Tag tag) {
    if (_exceptTags.contains(tag) || _containTags.contains(tag)) return;
    _exceptTags.add(tag);
    _searched = false;
    notifyListeners();
  }

  void removeExceptTag(Tag tag) {
    if (!exceptTags.contains(tag)) return;
    _exceptTags.remove(tag);
    _searched = false;
    notifyListeners();
  }
}
