import '../../constants/app_colors.dart';
import 'package:flutter/material.dart';

class CommonLabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isRequired;
  final TextInputType keyboardType;
  final double fontSize;
  final String? Function(String?)? validator;

  const CommonLabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.fontSize = 14,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: fontSize,
              color: AppColors.grey_212121,
              fontWeight: FontWeight.w400,
            ),
            children:
                isRequired
                    ? [
                      TextSpan(
                        text: " *",
                        style: TextStyle(color: AppColors.black),
                      ),
                    ]
                    : [],
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: AppColors.grey_212121.withOpacity(0.2),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class CommonLabeledDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final bool isRequired;
  final String? Function(String?)? validator;

  const CommonLabeledDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
    this.isRequired = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            children:
                isRequired
                    ? [
                      const TextSpan(
                        text: " *",
                        style: TextStyle(color: Colors.red),
                      ),
                    ]
                    : [],
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          validator: validator,
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          hint: Text(hint),
          items:
              items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
          onChanged: onChanged,
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
              color: AppColors.grey_212121,
              fontWeight: FontWeight.w400,
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
              color: AppColors.grey_212121,
              fontWeight: FontWeight.w400,
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
              color: AppColors.grey_212121,
              fontWeight: FontWeight.w400,
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
