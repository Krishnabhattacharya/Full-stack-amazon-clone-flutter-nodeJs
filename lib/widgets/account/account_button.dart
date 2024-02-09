import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final Function onTap;
  const AccountButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 45,
      width: 0.4.sw,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0),
        borderRadius: BorderRadius.circular(50),
        color: const Color.fromARGB(255, 246, 246, 246),
      ),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black12.withOpacity(0.03)),
        onPressed: onTap(),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
