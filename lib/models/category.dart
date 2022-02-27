import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'model.dart';

class Category extends Model {
  String name;
  String nature;
  Color color;
  IconData icon;
  Category({
    required this.name,
    required this.nature,
    required this.color,
    required this.icon,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nature': nature,
      'color': color.value,
      'icon': icon.codePoint,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'] ?? '',
      nature: map['nature'] ?? '',
      color: Color(map['color']),
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
