import 'package:flutter/material.dart';

enum Auth { signin, singup }

class RadioButtonStateChange extends ChangeNotifier {
  Auth _auth = Auth.singup;
  Auth get auth => _auth;

  void setAuth(Auth val) {
    _auth = val;
    notifyListeners();
  }
}
