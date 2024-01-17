import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_images.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import 'home_label_widget.dart';

class DashboardLoadingShimmer extends StatelessWidget {
  const DashboardLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey100,
      highlightColor: AppColors.grey300,
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 150,
              margin: const EdgeInsets.only(right: 5, left: 5),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          12.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.grey,
                child: Text(
                  AppStrings.offersTxt,
                  style: AppTextStyles.bodyBlack14
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                color: Colors.grey,
                child: Text(
                  AppStrings.seeAllTxt,
                  style: AppTextStyles.bodyBlack14.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          5.ph,
          SizedBox(
            height: 150,
            width: double.infinity,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  height: 150,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppImages.sliderImg1,
                      fit: BoxFit.fill,
                      height: 150,
                    ),
                  ),
                );
              },
            ),
          ),
          12.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.grey,
                child: Text(
                  AppStrings.offersTxt,
                  style: AppTextStyles.bodyBlack14
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                color: Colors.grey,
                child: Text(
                  AppStrings.seeAllTxt,
                  style: AppTextStyles.bodyBlack14.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          5.ph,
          SizedBox(
              height: 220,
              width: double.infinity,
              child: ListView.builder(
                itemCount: productList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Container(
                        height: 200,
                        width: 120,
                        decoration: const BoxDecoration(
                            color: AppColors.grey100,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: const EdgeInsets.only(right: 16),
                        child: IntrinsicWidth(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      const SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                      Positioned(
                                        bottom: -8,
                                        right: 1,
                                        child: FloatingActionButton(
                                          mini: true,
                                          heroTag: index.toString(),
                                          shape: const CircleBorder(),
                                          backgroundColor: Colors.white,
                                          child:
                                              const Icon(CupertinoIcons.heart),
                                          onPressed: () {},
                                        ),
                                      )
                                    ],
                                  )),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "product name",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "test",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          color: AppColors.primaryColor),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 3, bottom: 5),
                          child: Text(
                            "Most Selling",
                            style: AppTextStyles.bodyWhite10,
                          ),
                        ),
                      )
                    ],
                  );
                },
              )),
        ],
      ),
    );
  }
}
