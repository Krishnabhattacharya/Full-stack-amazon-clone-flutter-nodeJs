import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BellowBottomBar extends StatelessWidget {
  const BellowBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: EdgeInsets.only(left: 0.066.sw, right: 32, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: "Hello, ",
              style: const TextStyle(
                fontSize: 21,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              children: [
                TextSpan(
                  text: SharedServices.getLoginDetails()!.user!.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 180, 180, 180),
            radius: 22,
            child: Image.asset("assets/images/user.png"),
          )
        ],
      ),
    );
  }
}
