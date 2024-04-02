import 'package:amazon_clone/model/Auth_models/user_model.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _loginModel;
  User? get loginmodel => _loginModel;
  void setLoginDetails(User loginmodel) {
    _loginModel = loginmodel;
    notifyListeners();
  }

  bool get isLogin => _loginModel != null;
  bool get isadmin => _loginModel?.type?.toLowerCase() == 'admin';
}
