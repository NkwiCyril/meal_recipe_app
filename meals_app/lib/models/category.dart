import 'package:flutter/material.dart';

class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.title,
    required this.color,
  });

  final String id;
  final String title;
  final Color color;
}
