import 'dart:developer';

import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/custom_button.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address-screen";
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    t1.dispose();
    t2.dispose();
    t3.dispose();
    t4.dispose();
  }

  String addressToBeUse = "";
  void payPressed(String addressFromProvider) async {
    addressToBeUse = "";

    bool isForm = t1.text.isNotEmpty ||
        t2.text.isNotEmpty ||
        t3.text.isNotEmpty ||
        t4.text.isNotEmpty;

    if (isForm) {
      if (formKey.currentState!.validate()) {
        addressToBeUse = '${t1.text}, ${t2.text}, ${t3.text} - ${t4.text}';
        await Apiservices.addAddress(address: addressToBeUse, context: context);
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUse = addressFromProvider;
    } else {
      log('ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: SharedServices.getLoginDetails()!.user!.address!.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(SharedServices.getLoginDetails()!
                              .user!
                              .address
                              .toString()),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "OR",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                contentPadding: 16,
                                controller: t1,
                                label: "Flat, House no, Building",
                                context: context,
                                borderRadius: 0,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                contentPadding: 16,
                                controller: t2,
                                label: "Area, Street",
                                context: context,
                                borderRadius: 0,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                contentPadding: 16,
                                controller: t3,
                                label: "Pin Code",
                                context: context,
                                borderRadius: 0,
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                contentPadding: 16,
                                controller: t4,
                                label: "Town and City",
                                context: context,
                                borderRadius: 0,
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                            ],
                          )),
                    ),
                    CustomButton(
                        text: "ok",
                        onTap: () {
                          if (formKey.currentState!.validate() &&
                              SharedServices.getLoginDetails()!
                                  .user!
                                  .address!
                                  .isEmpty) {
                            payPressed(SharedServices.getLoginDetails()!
                                .user!
                                .address!);
                          } else {
                            log("else");
                          }
                        })
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          contentPadding: 16,
                          controller: t1,
                          label: "Flat, House no, Building",
                          context: context,
                          borderRadius: 0,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          contentPadding: 16,
                          controller: t2,
                          label: "Area, Street",
                          context: context,
                          borderRadius: 0,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          contentPadding: 16,
                          controller: t3,
                          label: "Pin Code",
                          context: context,
                          borderRadius: 0,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          contentPadding: 16,
                          controller: t4,
                          label: "Town and City",
                          context: context,
                          borderRadius: 0,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        CustomButton(
                            text: "ok",
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                payPressed(SharedServices.getLoginDetails()!
                                    .user!
                                    .address!);
                              }
                            })
                      ],
                    )),
              ),
      ),
    );
  }
}
