import '../../constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final IconData? icon;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onChanged;
  final bool isRequired;
  final Color? colorBorder;
  final double? fontSizeHint;
  final double? fontSizeTitle;
  final bool useDefaultHeight;

  const CustomDatePicker({
    super.key,
    required this.label,
    required this.onChanged,
    this.icon,
    this.selectedDate,
    this.isRequired = false,
    this.colorBorder,
    this.fontSizeHint,
    this.fontSizeTitle,
    this.useDefaultHeight = false,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        selectedDate != null
            ? DateFormat('dd/MM/yyyy').format(selectedDate!)
            : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSizeTitle ?? 16,
              fontWeight: FontWeight.w600,
            ),
            children: [
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: AppColors.red_ef4444),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final now = DateTime.now();
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? now,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                    useMaterial3: false,
                    colorScheme: ColorScheme.light(
                      primary: AppColors.orange_fe9f43,
                      onPrimary: Colors.white,
                      onSurface: Colors.black,
                    ),
                    appBarTheme: AppBarTheme(
                      backgroundColor: AppColors.orange_fe9f43,
                      foregroundColor: Colors.white,
                    ),
                    dialogTheme: DialogTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.orange_fe9f43,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              onChanged(pickedDate);
            }
          },
          child: AbsorbPointer(
            child: SizedBox(
              height: useDefaultHeight ? null : 47,
              child: TextFormField(
                readOnly: true,
                controller: TextEditingController(text: formattedDate),
                style: TextStyle(fontSize: fontSizeHint ?? 14),
                decoration: InputDecoration(
                  hintText: 'dd/mm/yyyy',
                  hintStyle: TextStyle(fontSize: fontSizeHint ?? 14),
                  suffixIcon: Icon(
                    icon ?? Icons.calendar_today,
                    size: 15,
                    color: Colors.black54,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: colorBorder ?? Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.orange_fe9f43),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTimePicker extends StatelessWidget {
  final String label;
  final IconData? icon;
  final DateTime? selectedTime;
  final ValueChanged<DateTime> onChanged;
  final Color? colorBorder;
  final double? fontSizeHint;
  final bool useDefaultHeight;
  final double? fontSizeTitle;

  const CustomTimePicker({
    super.key,
    required this.label,
    required this.onChanged,
    this.icon,
    this.selectedTime,
    this.colorBorder,
    this.fontSizeHint,
    this.fontSizeTitle,
    this.useDefaultHeight = false,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime =
        selectedTime != null ? DateFormat('hh:mm a').format(selectedTime!) : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSizeTitle ?? 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final now = DateTime.now();
            final initialTime = TimeOfDay.fromDateTime(selectedTime ?? now);

            final pickedTime = await showTimePicker(
              context: context,
              initialTime: initialTime,
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                    useMaterial3: false,
                    colorScheme: ColorScheme.light(
                      primary: AppColors.orange_fe9f43,
                      onPrimary: Colors.white,
                      onSurface: Colors.black,
                    ),
                    timePickerTheme: TimePickerThemeData(
                      dialHandColor: AppColors.orange_fe9f43,
                      hourMinuteTextColor: Colors.black,
                      entryModeIconColor: AppColors.orange_fe9f43,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.orange_fe9f43,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (pickedTime != null) {
              final nowDate = DateTime.now();
              final pickedDateTime = DateTime(
                nowDate.year,
                nowDate.month,
                nowDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
              onChanged(pickedDateTime);
            }
          },
          child: AbsorbPointer(
            child: SizedBox(
              height: useDefaultHeight ? null : 47,
              child: TextFormField(
                readOnly: true,
                controller: TextEditingController(text: formattedTime),
                style: TextStyle(fontSize: fontSizeHint ?? 14),
                decoration: InputDecoration(
                  hintText: 'Select time',
                  hintStyle: TextStyle(fontSize: fontSizeHint ?? 14),
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                  ), // match dropdown look
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: colorBorder ?? Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.orange_fe9f43),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDateTimePicker extends StatelessWidget {
  final String label;
  final IconData? icon;
  final DateTime? selectedDateTime;
  final ValueChanged<DateTime> onChanged;

  const CustomDateTimePicker({
    super.key,
    required this.label,
    required this.onChanged,
    this.icon,
    this.selectedDateTime,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDateTime =
        selectedDateTime != null
            ? DateFormat('dd MMM yyyy • hh:mm a').format(selectedDateTime!)
            : '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () async {
          final now = DateTime.now();
          final initialDate = selectedDateTime ?? now;

          // First pick the date
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: ThemeData(
                  useMaterial3: false,
                  colorScheme: ColorScheme.light(
                    primary: AppColors.orange_fe9f43,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                  appBarTheme: AppBarTheme(
                    backgroundColor: AppColors.orange_fe9f43,
                    foregroundColor: Colors.white,
                  ),
                  dialogTheme: const DialogTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.orange_fe9f43,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );

          if (pickedDate != null) {
            // Then pick the time
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(initialDate),
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                    useMaterial3: false,
                    colorScheme: ColorScheme.light(
                      primary: AppColors.orange_fe9f43,
                      onPrimary: Colors.white,
                      onSurface: Colors.black,
                    ),
                    timePickerTheme: TimePickerThemeData(
                      dialHandColor: AppColors.orange_fe9f43,
                      hourMinuteTextColor: Colors.black,
                      entryModeIconColor: AppColors.orange_fe9f43,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.orange_fe9f43,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (pickedTime != null) {
              final combinedDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
              onChanged(combinedDateTime);
            }
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: label,
              hintText: 'Select date & time',
              suffixIcon: Icon(icon ?? Icons.calendar_today),
              border: const UnderlineInputBorder(),
            ),
            controller: TextEditingController(text: formattedDateTime),
          ),
        ),
      ),
    );
  }
}
