import 'package:flutter/material.dart';

class CustomChipComponent extends StatelessWidget {
  final String title;
  final String? image;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double? fontSize;
  final bool showBorder;

  const CustomChipComponent({
    Key? key,
    required this.title,
    this.image,
    required this.backgroundColor,
    required this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
    this.borderRadius = 20.0,
    this.fontSize,
    this.showBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: showBorder ? textColor.withOpacity(0.2) : Colors.transparent)
      ),
      child: Row(
        children: [
          if(image != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(image!, width: 18, color: textColor,),
            ),
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
