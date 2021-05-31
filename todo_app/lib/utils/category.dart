import 'package:flutter/material.dart';

class Category {
  static const _icons = {'work': Icons.work, 'house-chore': Icons.house};

  static const _colors = {
    'work': Colors.lightGreen,
    'house-chore': Colors.lightBlue,
  };

  static const _colorsConstrast = {
    'work': Colors.white,
    'house-chore': Colors.white,
  };

  static Color getColor(String category) {
    return _colors[category] ?? Colors.transparent;
  }

  static Color getColorContrast(String category) {
    return _colorsConstrast[category] ?? Colors.black87;
  }

  static IconData getIcon(String category) {
    return _icons[category] ?? Icons.workspaces_filled;
  }
}
