import 'package:flutter/material.dart';

class SearchState with ChangeNotifier {
  bool _searched = false;
  bool _handleSearched = true;
  bool _handleExists = true;
  bool _searching = false;

  bool get searched => _searched;
  bool get handleSearched => _handleSearched;
  bool get handleExists => _handleExists;
  bool get searching => _searching;

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

  set seraching(bool searching) {
    _searching = searching;
    notifyListeners();
  }
}
