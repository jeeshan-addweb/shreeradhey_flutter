import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CustomFilterComponent extends StatelessWidget {
  final String text;
  final bool isSelected;
  Color? activeColor;
  Color? inactiveColor;
  Color? activeTextColor;
  Color? inactiveTextColor;
  double? borderRadius;
  final ValueChanged<bool> onSelected;

  CustomFilterComponent({
    Key? key,
    required this.text,
    required this.isSelected,
    this.activeColor,
    this.inactiveColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.borderRadius,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        text,
        style: TextStyle(
          color:
              isSelected
                  ? activeTextColor ?? AppColors.white
                  : inactiveTextColor ?? AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: activeColor ?? AppColors.orange_fe9f43,
      backgroundColor: inactiveColor ?? AppColors.white,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
      ),
    );
  }
}
