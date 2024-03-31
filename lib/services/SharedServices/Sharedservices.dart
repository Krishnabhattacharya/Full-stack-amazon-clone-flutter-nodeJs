import 'dart:convert';

import 'package:amazon_clone/model/Auth_models/user_model.dart';
import 'package:amazon_clone/services/SharedServices/Preferences.dart';
import 'package:flutter/material.dart';

//**************************************************************************** *//
//EMPORTANT                 //EMPORTANT                    //EMPORTANT

//%%%%%%%%%%%$$$$$$$$$$$$$###############@@@@@@@@@@@@@@@@@@@@@@@@@

//write this two line in main function

//------>>>     WidgetsFlutterBinding.ensureInitialized();
//---->>>     preferences = await SharedPreferences.getInstance();

//%%%%%%%%%%%%%%%%%%%%%$$$$$$$$$$$$$$$$$$########################

class SharedServices {
//set all the login details-----------------------------------
  static Future<void> setLoginDetails(UserModel? usermodel) async {
    if (usermodel != null) {
      preferences!.setString("login_details", jsonEncode(usermodel.toJson()));
    }
  }

  //update user-----------------------------------------------
  static Future<void> updateCart(List<Cart> updatedCart) async {
    UserModel? user = getLoginDetails();
    if (user != null) {
      user.user!.cart = updatedCart;
      await setLoginDetails(user);
    }
  }

//update address of a user
  static Future<void> updateAddress(String address) async {
    UserModel? user = getLoginDetails();
    if (user != null) {
      user.user!.address = address;
      await setLoginDetails(user);
    }
  }

// get the login details------------------------------------
  static UserModel? getLoginDetails() {
    String? jsonDetails = preferences!.getString("login_details");
    if (jsonDetails != null) {
      return UserModel.fromJson(jsonDecode(jsonDetails));
    }
    return null;
  }

//for login check//----------------------------------------
  static bool isLoggedIn() {
    return preferences!.getString("login_details") != null ? true : false;
  }

//for logout//--------------------------------------------
  static Future<bool> logout(BuildContext context) async {
    await preferences!.clear();
    return true;
  }
}
