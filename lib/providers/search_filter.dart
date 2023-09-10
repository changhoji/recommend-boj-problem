import 'package:flutter/material.dart';
import 'package:whattosolve/models/firestore_filter.dart';
import 'package:whattosolve/models/solvedac_problem.dart';

class SearchFilter with ChangeNotifier {
  late int _id = 1;
  String _filterName = "";
  int _levelStart = 1;
  int _levelEnd = 30;
  String _handle = "";
  SolvedacProblem? _suggestion;
  bool _translated = false;
  bool _searched = false;
  bool _handleSearched = true;
  bool _handleExists = true;
  bool _searching = false;
  List<Tag> _containTags = <Tag>[];
  List<Tag> _exceptTags = <Tag>[];

  SearchFilter(String filterName) {
    _filterName = filterName;
  }

  void assignNewFilter(SearchFilter another) {
    _id = another.id;
    _filterName = another.filterName;
    _levelStart = another.levelStart;
    _levelEnd = another.levelEnd;
    _handle = another.handle;
    _suggestion = null;
    _translated = another.translated;
    _searched = false;
    _handleSearched = true;
    _handleExists = true;
    _searching = false;
    _containTags = another.containTags;
    _exceptTags = another.exceptTags;
    notifyListeners();
  }

  SearchFilter.fromFirestoreFilter(
      FirestoreFilter data, int id, List<Tag> tags) {
    _id = id;
    _filterName = data.filterName;
    _levelStart = data.levelStart;
    _levelEnd = data.levelEnd;
    _handle = data.handle;
    _translated = data.translated;
    _containTags = data.containTags
        .map((key) => tags.firstWhere((tag) => tag.key == key))
        .toList();
    _exceptTags = data.exceptTags
        .map((key) => tags.firstWhere((tag) => tag.key == key))
        .toList();
  }

  int get id => _id;
  String get filterName => _filterName;
  int get levelStart => _levelStart;
  int get levelEnd => _levelEnd;
  String get handle => _handle;
  SolvedacProblem? get suggestion => _suggestion;
  bool get translated => _translated;
  bool get searched => _searched;
  bool get handleSearched => _handleSearched;
  bool get handleExists => _handleExists;
  bool get searching => _searching;
  List<Tag> get containTags => _containTags;
  List<Tag> get exceptTags => _exceptTags;

  Map<String, dynamic> toMap() {
    return {
      'filterName': _filterName,
      'levelStart': _levelStart,
      'levelEnd': _levelEnd,
      'handle': _handle,
      'translated': _translated,
      'containTags': _containTags.map((tag) => tag.key).toList(),
      'exceptTags': _exceptTags.map((tag) => tag.key).toList(),
    };
  }

  set filterName(String filterName) {
    _filterName = filterName;
    notifyListeners();
  }

  set levelStart(int levelStart) {
    _levelStart = levelStart;
    _searched = false;
    notifyListeners();
  }

  set levelEnd(int levelEnd) {
    _levelEnd = levelEnd;
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

  set handleSearched(bool handleSearched) {
    _handleSearched = handleSearched;
    notifyListeners();
  }

  set handleExists(bool handleExists) {
    _handleExists = handleExists;
    notifyListeners();
  }

  set searching(bool searching) {
    _searching = searching;
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
