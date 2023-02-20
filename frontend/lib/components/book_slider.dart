import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class BookSlider extends StatelessWidget {
  const BookSlider({super.key, required this.imgList, required this.height});

  final List<String> imgList;

  final double height;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: imgList
          .map((item) => Center(
              child: Image.network(item, fit: BoxFit.cover, height: height)))
          .toList(),
    );
  }
}
