import 'dart:developer';

import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:amazon_clone/services/provider/auth_provider.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/custom_text_form_field.dart';
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

  @override
  Widget build(BuildContext context) {
    log("rebuild");

    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AuthProvider>(
            builder: (context, authP, child) {
              Auth currentAuth = authP.auth;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Text(
                      "welcome",
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ListTile(
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
                  if (currentAuth == Auth.singup)
                    Container(
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
                                    await Apiservices.signupUser(
                                      name: name.text,
                                      email: email.text,
                                      password: pass.text,
                                    );
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                    ),
                  ListTile(
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
                  if (currentAuth == Auth.signin)
                    Container(
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
                                  text: "Sign In",
                                  onTap: () {})
                            ],
                          )),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
