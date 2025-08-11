import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CustomLoadingContainer extends StatelessWidget {
  CustomLoadingContainer({super.key, this.widthBox, this.heightBox, this.width, this.height, this.color, this.thickness});
  double? widthBox;
  double? heightBox;
  double? width;
  double? height;
  double? thickness;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightBox ?? 100,
      width: widthBox ?? MediaQuery.sizeOf(context).width,
      child: Center(child: CustomLoader(width: width, height: height, color: color, thickness: thickness,)),
    );
  }
}

class CustomLoader extends StatelessWidget {
  CustomLoader({super.key, this.width, this.height, this.color, this.thickness});
  double? width;
  double? height;
  double? thickness;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 20,
      height: height ?? 20,
      child: CircularProgressIndicator(color: color ?? AppColors.orange_fe9f43, strokeWidth: thickness,),
    );
  }
}

