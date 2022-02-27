import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'model.dart';

class Category extends Model {
  String name;
  String? id;
  String nature;
  Color color;
  IconData iconData;
  Category({
    required this.name,
    required this.nature,
    required this.color,
    required this.iconData,
    this.id,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nature': nature,
      'color': color.value,
      'icon': iconData.codePoint,
      'id': id
    };
  }

  String get idString => id ?? 'unknown';

  factory Category.fromMap(Map<String, dynamic> map, [String? docId]) {
    return Category(
      id: docId ?? map['id'] ?? '',
      name: map['name'] ?? '',
      nature: map['nature'] ?? '',
      color: Color(map['color']),
      iconData: IconData(map['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
