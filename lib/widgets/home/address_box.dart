import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressBoxWidget extends StatelessWidget {
  const AddressBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.048.sh,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 114, 226, 221),
        Color.fromARGB(255, 162, 236, 233)
      ], stops: [
        0.5,
        1.0
      ])),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.location_on_outlined,
              size: 20,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "Delivary to ${SharedServices.getLoginDetails()!.user!.name} - ${SharedServices.getLoginDetails()!.user!.address}",
              style: const TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          )),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 2),
            child: Icon(Icons.arrow_drop_down_outlined),
          )
        ],
      ),
    );
  }
}
