import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({super.key});

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
              "https://images.unsplash.com/photo-1682687221080-5cb261c645cb?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              fit: BoxFit.fitHeight,
              width: 0.5.sw,
              //  height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
