import '../../constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final String hintText;
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;
  final bool useDefaultHeight;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.useDefaultHeight = false,
    this.value,
    required String? Function(dynamic value) validator,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selected;

  // @override
  // void initState() {
  //   super.initState();
  //   selected = widget.initialValue;
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: widget.useDefaultHeight ? null : 47,
              child: DropdownButtonFormField<String>(
                value:
                    widget.items.contains(widget.value) ? widget.value : null,
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black12),
                  ),
                ),
                hint: Text(
                  widget.hintText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                    color: AppColors.grey.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                icon: Icon(Icons.keyboard_arrow_down_rounded),
                dropdownColor: Colors.white,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                items:
                    widget.items.toSet().map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selected = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class CommonLabeledDropdown<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? hintText;
  final ValueChanged<T?> onChanged;

  final double? fontSizeTitle;
  final Color? colorTitle;
  final Color? borderColor;
  final double? borderRadius;
  final double? height;

  const CommonLabeledDropdown({
    Key? key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText,
    this.fontSizeTitle,
    this.colorTitle,
    this.borderColor,
    this.borderRadius,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      borderSide: BorderSide(color: borderColor ?? Colors.grey.shade300),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSizeTitle ?? 16,
            color: colorTitle ?? Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.grey.shade300),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              hint: Text(hintText ?? 'Select an option'),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
