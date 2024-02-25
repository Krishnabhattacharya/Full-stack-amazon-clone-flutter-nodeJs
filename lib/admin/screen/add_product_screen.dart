import 'dart:developer';
import 'dart:io';

import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/admin/screen/post_screen.dart';
import 'package:amazon_clone/admin/services/admin_service.dart';
import 'package:amazon_clone/services/provider/admin_add_product_screen_isprograssing_change.dart';

import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/custom_text_form_field.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  AdminService adminService = AdminService();
  final addProductKey = GlobalKey<FormState>();
  TextEditingController productC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  TextEditingController priceC = TextEditingController();

  TextEditingController quantityC = TextEditingController();
  bool isProcessing = false;
  String catagoryValu = 'Mobiles';
  @override
  void dispose() {
    super.dispose();
    productC.dispose();
    descriptionC.dispose();
    priceC.dispose();
    quantityC.dispose();
  }

  List<XFile> finalimages = [];
  List<String> productCatagory = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  Future<List<XFile>?> pickImages() async {
    List<XFile> images = [];
    final ImagePicker picker = ImagePicker();

    try {
      images = await picker.pickMultiImage();
    } catch (e) {
      log('Error picking images: $e');
    }
    return images;
  }

  Future<void> selectImages() async {
    List<XFile>? selectedImages = await pickImages();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        finalimages = selectedImages;
      });
    }
  }

  addProduct() async {
    if (addProductKey.currentState!.validate() &&
        finalimages.isNotEmpty &&
        !isProcessing) {
      Provider.of<IsprograssingChange>(context, listen: false)
          .changeIsPrograssing(true);

      try {
        await adminService.selProduct(
          context: context,
          name: productC.text,
          desc: descriptionC.text,
          price: double.parse(priceC.text),
          quantity: int.parse(quantityC.text),
          catagory: catagoryValu,
          images: finalimages,
        );
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, PostScreen.routeName);
        }
      } catch (e) {
        log("Error: $e");
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("An error occurred")),
          );
        });
      } finally {
        Future.delayed(Duration.zero, () {
          Provider.of<IsprograssingChange>(context, listen: false)
              .changeIsPrograssing(false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    log("rebuild");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Text(
              "Add Product",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            )),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: addProductKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  finalimages.isNotEmpty
                      ? CarouselSlider(
                          items: finalimages.map((imageUrl) {
                            return Image.file(
                              File(imageUrl.path),
                              fit: BoxFit.cover,
                              height: 0.28.sh,
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 0.28.sh,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            enableInfiniteScroll: true,
                            reverse: false,
                            // autoPlay: true,
                            // autoPlayInterval: Duration(seconds: 3),
                            // autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        )
                      : InkWell(
                          onTap: selectImages,
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                // height: 0.2.sh,
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open_outlined,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Select Product Images",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              255, 164, 164, 164)),
                                    )
                                  ],
                                ),
                              )),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                      borderRadius: 5,
                      controller: productC,
                      label: "Product Name",
                      context: context),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: descriptionC,
                    maxLines: 7,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 185, 185, 185)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: "Enter Description",
                      //  labelText: "Enter Description",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      borderRadius: 5,
                      controller: priceC,
                      label: "Price",
                      context: context),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      borderRadius: 5,
                      controller: quantityC,
                      label: "Quantity",
                      context: context),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        value: catagoryValu,
                        items: productCatagory.map((String item) {
                          return DropdownMenuItem(
                              value: item, child: Text(item));
                        }).toList(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onChanged: (String? val) {
                          setState(() {
                            catagoryValu = val!;
                          });
                        },
                      ),
                    ),
                  ),
                  Consumer<IsprograssingChange>(
                      builder: (context, value, child) {
                    return value.isPrograssing
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            text: "Sell",
                            onTap: addProduct,
                            color: GlobalVariables.secondaryColor,
                          );
                  })
                ],
              ),
            )),
      ),
    );
  }
}
