import 'package:flutter/material.dart';

class Controllers with ChangeNotifier {
  final TextEditingController _handleController = TextEditingController();

  TextEditingController get handleController => _handleController;

  void changeHandle(String handle) {
    _handleController.text = handle;
    notifyListeners();
  }
}
