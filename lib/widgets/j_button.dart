import 'package:budget/constants/app_colors.dart';
import 'package:budget/constants/design_system.dart';
import 'package:flutter/material.dart';

enum JButtonStyle { outline, solid }
enum JButtonColorStyle { primary, secondary }

class JButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final IconData? iconData;
  final double borderRadius;
  final void Function()? onPressed;
  final JButtonStyle style;
  final JButtonColorStyle? colorStyle;

  const JButton(
      {Key? key,
      required this.text,
      this.color,
      this.onPressed,
      this.borderRadius = BorderRad.r,
      this.iconData,
      this.textColor,
      this.style = JButtonStyle.solid,
      this.colorStyle})
      : super(key: key);

  Color getColorFromColorStyle() {
    if (color != null) return color!;
    switch (colorStyle) {
      case JButtonColorStyle.primary:
        return AppColor.primaryColor;
      default:
        return AppColor.secondaryColor;
    }
  }

  Widget getOutlinedButton() {
    final Color _color = getColorFromColorStyle();
    final Widget _content = Padding(
      padding: const EdgeInsets.all(Inset.r),
      child: Text(
        text,
        style: TextStyle(color: _color),
      ),
    );

    ButtonStyle _style = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      side: BorderSide(
        width: BorderWidth.r,
        color: _color,
      ),
    );
    return iconData != null
        ? OutlinedButton.icon(
            style: _style,
            onPressed: onPressed,
            icon: Icon(
              iconData,
              color: _color,
            ),
            label: _content)
        : OutlinedButton(
            onPressed: onPressed,
            child: _content,
          );
  }

  Widget getElivatedButton() {
    Color _color = getColorFromColorStyle();
    Color _textColor = textColor == null
        ? _color.computeLuminance() > 0.5
            ? Colors.black
            : Colors.white
        : textColor!;
    final Widget _content = Padding(
      padding: const EdgeInsets.all(Inset.r),
      child: Text(
        text,
        style: TextStyle(color: _textColor),
      ),
    );

    ButtonStyle _style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      maximumSize: const Size(double.infinity, double.infinity),
      primary: _color,
      elevation: 0,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: FontSize.r,
      ),
    );

    return iconData != null
        ? ElevatedButton.icon(
            icon: Icon(
              iconData,
              color: _textColor,
            ),
            style: _style,
            onPressed: onPressed,
            label: _content,
          )
        : ElevatedButton(
            style: _style,
            onPressed: onPressed,
            child: _content,
          );
  }

  @override
  Widget build(BuildContext context) {
    if (style == JButtonStyle.outline) {
      return getOutlinedButton();
    }

    return getElivatedButton();
  }
}
