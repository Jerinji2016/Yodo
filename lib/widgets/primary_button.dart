import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double borderRadius;
  final IconData? prefixIcon;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.borderRadius = 8.0,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonChild = Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
    );

    if (prefixIcon != null) {
      buttonChild = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(prefixIcon, color: Colors.white),
          const SizedBox(width: 4.0),
          buttonChild,
        ],
      );
    }

    return Material(
      color: Colors.orange,
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: buttonChild,
        ),
      ),
    );
  }
}
