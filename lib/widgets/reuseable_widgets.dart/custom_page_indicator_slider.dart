import 'package:flutter/material.dart';

class CustomPageIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const CustomPageIndicator({
    Key? key,
    required this.currentIndex,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          width: index == currentIndex ? 16.0 : 8.0,
          height: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex ? Colors.teal : Colors.grey,
          ),
        );
      }),
    );
  }
}
