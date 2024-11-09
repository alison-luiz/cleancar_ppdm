import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool enabled;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    this.borderRadius = 8.0,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled
            ? (backgroundColor ?? Theme.of(context).primaryColor)
            : Colors.grey,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: enabled ? (textColor ?? Colors.white) : Colors.black38,
        ),
      ),
    );
  }
}
