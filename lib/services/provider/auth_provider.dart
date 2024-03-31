import 'package:amazon_clone/model/Auth_models/user_model.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _loginModel;
  UserModel? get loginmodel => _loginModel;
  void setLoginDetails(UserModel loginmodel) {
    _loginModel = loginmodel;
    notifyListeners();
  }

  bool get isLogin => _loginModel != null;
  bool get isadmin => _loginModel?.user?.type?.toLowerCase() == 'admin';
}
