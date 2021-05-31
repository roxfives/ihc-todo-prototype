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

  Color getColor(String category) {
    return _colors[category] ?? Colors.transparent;
  }

  Color getColorContrast(String category) {
    return _colorsConstrast[category] ?? Colors.black87;
  }

  IconData getIcon(String category) {
    return _icons[category] ?? Icons.workspaces_filled;
  }
}
