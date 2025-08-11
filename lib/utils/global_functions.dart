import 'package:image_picker/image_picker.dart';

import '../constants/app_strings.dart';

import 'package:intl/intl.dart';

class GlobalFunctions {
  static Future<String?> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    return image?.path;
  }

  static Future<String?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image?.path; // returns null if no image is selected
  }

  static String getCurrencyString(String price) {
    return "${AppStrings.currency}$price";
  }

  static String getInitials(String firstName, String lastName) {
    String firstInitial = firstName.isNotEmpty ? firstName[0] : '';
    String lastInitial = lastName.isNotEmpty ? lastName[0] : '';
    return (firstInitial + lastInitial).toUpperCase();
  }

  static String formatDate(DateTime dateTime) {
    return "${dateTime.year.toString().padLeft(4, '0')}-"
        "${dateTime.month.toString().padLeft(2, '0')}-"
        "${dateTime.day.toString().padLeft(2, '0')}";
  }

  static String formatTime(DateTime? time) {
    if (time == null) return '';
    return DateFormat('hh:mm a').format(time);
  }

  static String formatTo24Hour(DateTime? time) {
    if (time == null) return '';
    return DateFormat('HH:mm').format(time);
  }

  static String convertToAmPm(String time24) {
    final inputFormat = DateFormat("HH:mm:ss");
    final outputFormat = DateFormat("hh:mm a");

    final dateTime = inputFormat.parse(time24);
    return outputFormat.format(dateTime);
  }

  static String convertToHourMinute(String timeStr) {
    final time = DateFormat("HH:mm:ss").parse(timeStr);
    return DateFormat("HH:mm").format(time); // "H:i" equivalent
  }

  static String getInitialsMy(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return "?";
  }
}
