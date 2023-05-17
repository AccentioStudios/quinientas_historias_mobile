import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants.dart';

class ThemedTextFormField extends StatelessWidget {
  const ThemedTextFormField({
    super.key,
    this.hintText,
    this.prefixIconSvgPath,
    this.keyboardType,
    required this.controller,
    this.obscureText = false,
    this.enabled,
    this.autofocus = false,
    this.errorText,
    this.onChanged,
    this.focusNode,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.style,
    this.contentPadding,
    this.borderRadius,
    this.suffix,
  });

  final String? hintText;
  final String? prefixIconSvgPath;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final bool? enabled;
  final bool autofocus;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      scrollPadding: const EdgeInsets.only(bottom: 40),
      textCapitalization: keyboardType == TextInputType.name
          ? TextCapitalization.words
          : TextCapitalization.none,
      focusNode: focusNode,
      autofocus: autofocus,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        suffix: suffix,
        errorText: errorText,
        prefixIcon: prefixIconSvgPath != null
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 14, bottom: 0, right: 13),
                child: SvgPicture.asset(
                  prefixIconSvgPath!,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            : null,
        prefixIconColor: Theme.of(context).colorScheme.onSurface,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              left: prefixIconSvgPath == null ? 21 : 0,
              top: 20,
              bottom: 20,
              right: 20,
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x00000000), width: 1),
          borderRadius: borderRadius ?? Constants.borderRadius50,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: const Color(0xFFFFFFFF).withOpacity(0.3), width: 1),
          borderRadius: borderRadius ?? Constants.borderRadius50,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: const Color.fromARGB(255, 199, 199, 199).withOpacity(0.12),
              width: 1),
          borderRadius: borderRadius ?? Constants.borderRadius50,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error.withOpacity(0.5),
              width: 1),
          borderRadius: borderRadius ?? Constants.borderRadius50,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.error, width: 1),
          borderRadius: borderRadius ?? Constants.borderRadius50,
        ),
        errorStyle: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontSize: 15,
            overflow: TextOverflow.fade),
        filled: enabled == false ? false : true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        hintText: hintText,
      ),
    );
  }
}
