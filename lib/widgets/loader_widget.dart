import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../core/app_colors.dart';
import 'custom_button.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index.isEven ? AppColors.primaryColor : AppColors.accent,
            ),
          );
        },
      ),
    );
  }
}

class CustomButtonLoader extends StatelessWidget {
  const CustomButtonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {},
      isGradient: false,
      child: Center(
        child: SpinKitCircle(
          size: 25,
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index.isEven ? Colors.white : AppColors.grey100,
              ),
            );
          },
        ),
      ),
    );
  }
}
