import 'package:flutter/material.dart';

extension SpacedWidgets on List<Widget> {
  List<Widget> withSpacing(Widget spacer) {
    if (length <= 1) return this;
    final spaced = <Widget>[];
    for (int i = 0; i < length; i++) {
      spaced.add(this[i]);
      if (i != length - 1) {
        spaced.add(spacer);
      }
    }
    return spaced;
  }
}

extension DateFormatting on DateTime {
  String toUiDateFormat() {
    final year = this.year;
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }
}

extension CapitalizeWords on String {
  String capitalizeEachWord() {
    if (isEmpty) return this;

    return split(' ')
        .map((word) {
          if (word.trim().isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}
