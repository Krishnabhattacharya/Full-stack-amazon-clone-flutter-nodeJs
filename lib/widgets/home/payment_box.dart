import 'package:flutter/material.dart';

class PaymentBox extends StatelessWidget {
  const PaymentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 5),
          ],
        ),
        height: 190,
        width: 200,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset("assets/images/pay.png"),
                  ),
                  const Text(
                    "Amazon pay",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset(
                      "assets/images/card.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                  const Text(
                    "send money",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset(
                      "assets/images/qr-code.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                  const Text(
                    "scan Qr",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset(
                      "assets/images/bill.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                  const Text(
                    "pay bill",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
