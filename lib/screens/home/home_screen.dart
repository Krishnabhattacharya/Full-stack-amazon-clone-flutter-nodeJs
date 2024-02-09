import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text((SharedServices.getLoginDetails()!.user!.name.toString())),
      ),
    );
  }
}
