import 'dart:developer';

import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/admin/screen/admin_screen.dart';

import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:amazon_clone/services/provider/auth_provider.dart';
import 'package:amazon_clone/services/provider/radio_button_state_change.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/bottom_bar.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/custom_button.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth_screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final signupKey = GlobalKey<FormState>();
  final signinKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  // TextEditingController loginController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    pass.dispose();
  }

  void showSnackbar(BuildContext contextc, String content) {
    final snack = SnackBar(
      content: Text(
        content,
        style: TextStyle(color: Colors.red),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    log("rebuild");

    return SafeArea(
      child: Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: Consumer<RadioButtonStateChange>(
          builder: (context, authP, child) {
            Auth currentAuth = authP.auth;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: GlobalVariables.greyBackgroundCOlor,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 197, 197, 197),
                                blurRadius: 1,
                                blurStyle: BlurStyle.normal,
                                offset: Offset(0, 1)),
                          ]),
                      child: Image.asset(
                        "assets/images/amazon_in.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14.0, right: 10, top: 10, bottom: 5),
                    child: Text(
                      "welcome",
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10,
                    ),
                    child: ListTile(
                      tileColor: currentAuth == Auth.singup
                          ? GlobalVariables.backgroundColor
                          : GlobalVariables.greyBackgroundCOlor,
                      title: Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.singup,
                        groupValue: currentAuth,
                        onChanged: (Auth? value) {
                          authP.setAuth(value!);
                        },
                      ),
                    ),
                  ),
                  if (currentAuth == Auth.singup)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        color: Colors.white,
                        child: Form(
                            key: signupKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  contentPadding: 16,
                                  controller: name,
                                  label: "Name",
                                  context: context,
                                  borderRadius: 0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                  contentPadding: 16,
                                  controller: email,
                                  label: "Email",
                                  context: context,
                                  borderRadius: 0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                  contentPadding: 16,
                                  controller: pass,
                                  label: "Password",
                                  context: context,
                                  borderRadius: 0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                    color: GlobalVariables.secondaryColor,
                                    text: "Sign Up",
                                    onTap: () async {
                                      if (name.text.isEmpty ||
                                          email.text.isEmpty ||
                                          pass.text.isEmpty) {
                                        showSnackbar(context,
                                            "Please Enter all Details");
                                      }
                                      await Apiservices.signupUser(
                                          name: name.text,
                                          email: email.text,
                                          password: pass.text,
                                          context: context);
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10,
                    ),
                    child: ListTile(
                      tileColor: currentAuth == Auth.signin
                          ? GlobalVariables.backgroundColor
                          : GlobalVariables.greyBackgroundCOlor,
                      title: Text(
                        "Sign-In",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signin,
                        groupValue: currentAuth,
                        onChanged: (Auth? value) {
                          authP.setAuth(value!);
                        },
                      ),
                    ),
                  ),
                  if (currentAuth == Auth.signin)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        color: Colors.white,
                        child: Form(
                            key: signupKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  contentPadding: 16,
                                  controller: email,
                                  label: "Email",
                                  context: context,
                                  borderRadius: 0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                  contentPadding: 16,
                                  controller: pass,
                                  label: "Password",
                                  context: context,
                                  borderRadius: 0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                    color: GlobalVariables.secondaryColor,
                                    text: "Sign In",
                                    onTap: () {
                                      Apiservices.loginUser(
                                              context: context,
                                              email: email.text,
                                              password: pass.text)
                                          .then((value) {
                                        if (value) {
                                          if (value) {
                                            final type = SharedServices
                                                    .getLoginDetails()!
                                                .user!
                                                .type!
                                                .toLowerCase();
                                            if (type == "admin") {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AdminScreen()),
                                              );
                                            } else {
                                              // User is logged in but not an admin, navigate to BottomBar
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BottomBar()),
                                              );
                                            }
                                          }
                                        }
                                      });
                                    }),
                                const SizedBox(
                                  height: 9,
                                ),
                              ],
                            )),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.1.sh, left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Condition of use",
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Privacy Notice",
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Help",
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "© 1996-2024, Amazon.com Inc or its affilates.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 156, 156, 156)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
