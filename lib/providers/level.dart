import 'package:flutter/material.dart';

class Level with ChangeNotifier {
  String _level = "r1";
  String get level => _level;

  set(String level) {
    _level = level;
    notifyListeners();
  }
}
