import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

Future<IconData?> showIconPicker(context,
    {List<IconPack>? iconPackModes}) async {
  IconData? iconData = await FlutterIconPicker.showIconPicker(context,
      iconPackModes: iconPackModes ?? [IconPack.material]);

  return iconData;
}
