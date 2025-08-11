import 'custom_loading_container.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CommonElevatedButtonWithIcon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final IconData? icon;
  final String? assetImagePath;
  final double? width;

  const CommonElevatedButtonWithIcon({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.textColor = Colors.white,
    this.icon,
    this.assetImagePath,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? leadingIcon;

    if (icon != null) {
      leadingIcon = Icon(icon, color: textColor);
    } else if (assetImagePath != null && assetImagePath!.isNotEmpty) {
      leadingIcon = Image.asset(
        assetImagePath!,
        width: 20,
        height: 20,
        color: textColor,
      );
    } else {
      leadingIcon = const SizedBox.shrink();
    }

    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        label: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        icon: leadingIcon,
      ),
    );
  }
}

class CommonStepButtons extends StatelessWidget {
  final bool showBack;
  final VoidCallback onBack;
  final VoidCallback onNextOrSubmit;
  final bool isFinalStep;

  const CommonStepButtons({
    super.key,
    required this.showBack,
    required this.onBack,
    required this.onNextOrSubmit,
    required this.isFinalStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          showBack ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
      children: [
        if (showBack)
          OutlinedButton(
            onPressed: onBack,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.black,
              side: BorderSide(color: AppColors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text("Back"),
          ),
        ElevatedButton(
          onPressed: onNextOrSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange_fe9f43,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Text(isFinalStep ? "Submit for Approval" : "Next"),
        ),
      ],
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  final IconData? icon;
  final String? assetImagePath;

  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final Color? backgroundColor;
  final FontWeight? fontWeightText;
  final bool isLoading;

  const CustomOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.assetImagePath,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.backgroundColor,
    this.fontWeightText,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget;

    if (assetImagePath != null) {
      leadingWidget = Image.asset(
        assetImagePath!,
        width: 16,
        height: 16,
        color: textColor,
      );
    } else if (icon != null) {
      leadingWidget = Icon(icon, size: 16, color: textColor ?? Colors.black);
    }

    return ElevatedButton(
      onPressed: !isLoading && onPressed != null ? onPressed : () {},
      style: ElevatedButton.styleFrom(
        backgroundColor:
            onPressed == null
                ? backgroundColor?.withOpacity(0.5) ??
                    Colors.white.withOpacity(0.5)
                : backgroundColor ?? Colors.white,
        side: BorderSide(color: borderColor ?? Colors.black12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child:
          isLoading
              ? CustomLoader(color: textColor)
              : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leadingWidget != null) ...[
                    leadingWidget,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor ?? Colors.black,
                      fontWeight: fontWeightText ?? FontWeight.bold,
                    ),
                  ),
                ],
              ),
    );
  }
}
