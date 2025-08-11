import '../../constants/app_colors.dart';
import 'package:flutter/material.dart';

class CommonLabeledTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final Widget? suffixIcon;
  final double? height;
  final double? fontSizeTitle;
  final double? borderRadius;
  final Color? borderColor;
  final Color? colorTitle;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  const CommonLabeledTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.hintText,
    this.height,
    this.fontSizeTitle,
    this.borderColor,
    this.colorTitle,
    this.borderRadius,
    this.validator,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSizeTitle ?? 14,
            color: colorTitle ?? Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: height,
          child: TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: inputType,
            obscureText: obscureText,
            autovalidateMode: autovalidateMode,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: BorderSide(color: borderColor ?? AppColors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: BorderSide(color: borderColor ?? AppColors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: BorderSide(color: Colors.orange),
              ),
            ),
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
      ],
    );
  }
}

class CommonEmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final double? height;
  final Color? borderColor;

  const CommonEmailTextField({
    Key? key,
    required this.controller,
    this.suffixIcon,
    this.label,
    this.validator,
    this.hintText,
    this.height,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasLabel = label != null && label!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel) ...[
          Text(
            label!,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 6),
        ],
        SizedBox(
          height: height,
          child: TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: hintText ?? 'Enter your email',
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? AppColors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommonPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final double? height;
  final Color? borderColor;

  const CommonPasswordTextField({
    Key? key,
    required this.controller,
    this.label,
    this.hintText,
    this.validator,
    this.height,
    this.borderColor,
  }) : super(key: key);

  @override
  State<CommonPasswordTextField> createState() =>
      _CommonPasswordTextFieldState();
}

class _CommonPasswordTextFieldState extends State<CommonPasswordTextField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 6),
        ],
        SizedBox(
          height: widget.height,
          child: TextFormField(
            validator: widget.validator,
            controller: widget.controller,
            obscureText: isObscured,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Enter your password',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.grey,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => isObscured = !isObscured),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommonPhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final Color? borderColor;
  final double? borderRadius;
  final double? height;
  final double? fontSizeTitle;
  final String? Function(String?)? validator;

  const CommonPhoneTextField({
    Key? key,
    required this.controller,
    this.label,
    this.hintText = '+91 XXXXXXXXXX',
    this.borderColor,
    this.borderRadius,
    this.height,
    this.fontSizeTitle,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasLabel = label != null && label!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel) ...[
          Text(
            label!,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: fontSizeTitle ?? 14,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 6),
        ],
        SizedBox(
          height: height,
          child: TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: BorderSide(color: borderColor ?? AppColors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: BorderSide(color: borderColor ?? AppColors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: BorderSide(color: Colors.orange),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommonHintOnlyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;

  const CommonHintOnlyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }
}
