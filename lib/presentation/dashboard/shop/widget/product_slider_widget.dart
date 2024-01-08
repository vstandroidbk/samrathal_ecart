import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_images.dart';

class ProductSliderWidget extends StatefulWidget {
  const ProductSliderWidget({super.key});

  @override
  State<ProductSliderWidget> createState() => _ProductSliderWidgetState();
}

class _ProductSliderWidgetState extends State<ProductSliderWidget> {
  int _currentPage = 0;
  final CarouselController _sliderController = CarouselController();

  List<String> sliderUrls = [
    // AppImages.sliderImg1,
    AppImages.productImg1,
    AppImages.productImg3,
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 150,
              autoPlay: true,
              aspectRatio: 2.0,
              disableCenter: true,
              viewportFraction: 1,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              }),
          items: sliderUrls.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      // width: size.width,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            width: double.infinity,
                            height: 150,
                            i,
                            // imageUrl: i,
                            /*Network.baseUrl + widget.sliderImgPath + i.image!,*/
                            fit: BoxFit.fill,
                            // placeholder: (context, url) => const SizedBox(),
                            // errorWidget: (context, url, error) =>
                            //     const Icon(Icons.error),
                          ),
                        ),
                      )),
                );
              },
            );
          }).toList(),
          carouselController: _sliderController,
        ),
        Positioned(
          bottom: 5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(sliderUrls.length, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? AppColors.enabledSliderColor
                        : AppColors.disabledSliderColor,
                  ),
                );
              }),
            ),
          ),
        )
      ],
    );
  }
}
