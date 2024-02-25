import 'package:flutter/material.dart';

class IsprograssingChange extends ChangeNotifier {
  bool _isPrograssing = false;

  bool get isPrograssing => _isPrograssing;
  void changeIsPrograssing(bool isP) {
    _isPrograssing = isP;
    notifyListeners();
  }
}
