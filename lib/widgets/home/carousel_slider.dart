import 'package:amazon_clone/constant/global_variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarousalSliderImage extends StatelessWidget {
  const CarousalSliderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((imageUrl) {
        return Image.network(
          imageUrl,
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
    );
  }
}
