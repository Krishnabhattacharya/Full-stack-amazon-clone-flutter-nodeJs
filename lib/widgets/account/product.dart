import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleProduct extends StatelessWidget {
  final String images;
  const SingleProduct({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.4),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: 0.5.sw,
          padding: const EdgeInsets.all(10),
          child: Container(
            // Add a background color for the Image
            color: Colors.amber,
            child: Image.network(
              images, fit: BoxFit.fitHeight,
              width: 0.5.sw,
              //  height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
