import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../core/api_const.dart';
import '../../../../core/app_colors.dart';
import '../../../../data/model/dashboard/dashboard_data_model.dart';

class SliderWidget extends StatefulWidget {
  final List<SliderData>? sliderData;
  final String? sliderImgPath;

  const SliderWidget(
      {Key? key, required this.sliderData, required this.sliderImgPath})
      : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _currentPage = 0;
  final CarouselController _sliderController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (widget.sliderData != null && widget.sliderImgPath != null)
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
            items: widget.sliderData?.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        // width: size.width,
                        margin: const EdgeInsets.only(right: 5, left: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: ApiEndPoints.baseUrl +
                                  widget.sliderImgPath! +
                                  i.sliderImage!,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              placeholder: (context, url) => const SizedBox(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        )),
                  );
                },
              );
            }).toList(),
            carouselController: _sliderController,
          ),
        if (widget.sliderData != null && widget.sliderImgPath != null)
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
                children: List.generate(widget.sliderData!.length, (index) {
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
