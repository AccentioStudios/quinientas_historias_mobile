import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    Key? key,
    required this.text,
    this.color,
    this.height = 19,
    this.onTap,
    this.decoration = TextDecoration.underline,
  }) : super(key: key);
  final String text;
  final Color? color;
  final TextDecoration? decoration;
  final double? height;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    Color colorText = color ?? Theme.of(context).primaryColor;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              color: colorText,
              height: 1.2,
              decoration: decoration,
            ),
          ),
        ),
      ),
    );
  }
}
