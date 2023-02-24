import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void updatedSelectedIndex(int index) {
    _selectedIndex = index;
    debugPrint("tapped : $_selectedIndex");
    notifyListeners();
  }
}
