import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';
import 'custom_page_indicator.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final banners = [
    "assets/png/banner1.png",
    "assets/png/banner2.png",
    "assets/png/banner1.png",
  ];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 390.w,
          height: 240.r,
          child: CarouselSlider.builder(
            itemCount: banners.length,
            itemBuilder: (context, index, realIndex) {
              return Image.asset(
                banners[index],
                width: 359.r,
                height: 240.r,
                fit: BoxFit.fill,
              );
            },
            options: CarouselOptions(
              height: 240.r,
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) =>
                  setState(() => _selected = index),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        CustomPageIndicator(
          selected: _selected,
          activeColor: AppColors.grey,
          inactiveColor: AppColors.darkGrey,
        ),
      ],
    );
  }
}
