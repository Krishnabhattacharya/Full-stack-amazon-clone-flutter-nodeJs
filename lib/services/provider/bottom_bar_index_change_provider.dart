import 'package:flutter/material.dart';

class BottobarIndexChange extends ChangeNotifier {
  int _page = 0;
  int get page => _page;
  void updatePage(int p) {
    _page = p;
    notifyListeners();
  }
}
