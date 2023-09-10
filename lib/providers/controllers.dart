import 'package:flutter/material.dart';

class Controllers with ChangeNotifier {
  final TextEditingController _handleController = TextEditingController();
  final TextEditingController _filterNameController = TextEditingController();

  TextEditingController get handleController => _handleController;
  TextEditingController get filterNameController => _filterNameController;

  void changeHandle(String handle) {
    _handleController.text = handle;
    notifyListeners();
  }

  void changeFilterName(String filterName) {
    _filterNameController.text = filterName;
    notifyListeners();
  }
}
