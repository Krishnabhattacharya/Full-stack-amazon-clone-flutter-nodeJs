import 'package:amazon_clone/model/Auth_models/login_model.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  LoginModel? _loginModel;
  LoginModel? get loginmodel => _loginModel;
  void setLoginDetails(LoginModel loginmodel) {
    _loginModel = loginmodel;
    notifyListeners();
  }

  bool get isLogin => _loginModel != null;
  bool get isadmin => _loginModel?.user?.type?.toLowerCase() == 'admin';
}
