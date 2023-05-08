import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants.dart';

class ThemedDropdown<T> extends StatefulWidget {
  const ThemedDropdown(
      {super.key,
      required this.onChanged,
      required this.items,
      this.borderRadius,
      this.suffix,
      this.contentPadding,
      this.errorText,
      this.enabled,
      this.prefixIconSvgPath,
      this.hint,
      this.validator});

  final void Function(dynamic) onChanged;
  final String? errorText;
  final Widget? suffix;
  final BorderRadius? borderRadius;
  final String? prefixIconSvgPath;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enabled;
  final List<DropdownMenuItem<T>>? items;
  final Widget? hint;
  final String? Function(T?)? validator;
  @override
  State<ThemedDropdown<T>> createState() => _ThemedDropdownState<T>();
}

class _ThemedDropdownState<T> extends State<ThemedDropdown<T>> {
  T? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: dropdownValue,
      onChanged: (T? newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        widget.onChanged(newValue);
      },
      hint: widget.hint,
      isExpanded: true,
      items: widget.items,
      validator: widget.validator,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        suffix: widget.suffix,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIconSvgPath != null
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 14, bottom: 0, right: 13),
                child: SvgPicture.asset(
                  widget.prefixIconSvgPath!,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            : null,
        prefixIconColor: Theme.of(context).colorScheme.onSurface,
        contentPadding: widget.contentPadding ??
            EdgeInsets.only(
              left: widget.prefixIconSvgPath == null ? 21 : 0,
              top: 20,
              bottom: 20,
              right: 20,
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x00000000), width: 1),
          borderRadius: widget.borderRadius ?? Constants.borderRadius50,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: const Color(0xFFFFFFFF).withOpacity(0.3), width: 1),
          borderRadius: widget.borderRadius ?? Constants.borderRadius50,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: const Color.fromARGB(255, 199, 199, 199).withOpacity(0.12),
              width: 1),
          borderRadius: widget.borderRadius ?? Constants.borderRadius50,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error.withOpacity(0.5),
              width: 1),
          borderRadius: widget.borderRadius ?? Constants.borderRadius50,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.error, width: 1),
          borderRadius: widget.borderRadius ?? Constants.borderRadius50,
        ),
        errorStyle: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontSize: 15,
            overflow: TextOverflow.fade),
        filled: widget.enabled == false ? false : true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      // underline: const SizedBox.shrink(),
      // borderRadius: widget.borderRadius ?? Constants.borderRadius50,
    );
    // return DropDownMultiSelect(
    //   validator: widget.validator,
    //   childBuilder: (List<String> item) {
    //     return Padding(
    //       padding: const EdgeInsets.only(
    //           left: Constants.space16, right: Constants.space41),
    //       child: SingleChildScrollView(
    //         physics: const BouncingScrollPhysics(),
    //         scrollDirection: Axis.horizontal,
    //         child: Row(
    //           children: [
    //             ...item.map((e) => Padding(
    //                   padding: const EdgeInsets.only(right: Constants.space8),
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       borderRadius:
    //                           widget.borderRadius ?? Constants.borderRadius50,
    //                       color: Theme.of(context)
    //                           .colorScheme
    //                           .onPrimaryContainer
    //                           .withOpacity(0.2),
    //                     ),
    //                     padding: const EdgeInsets.all(8),
    //                     child: Text(
    //                       e,
    //                       style: const TextStyle(fontSize: 16),
    //                     ),
    //                   ),
    //                 )),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    //   decoration: InputDecoration(
    //     alignLabelWithHint: true,
    //     suffix: widget.suffix,
    //     errorText: widget.errorText,
    //     prefixIcon: widget.prefixIconSvgPath != null
    //         ? Padding(
    //             padding: const EdgeInsets.only(
    //                 top: 0.0, left: 14, bottom: 0, right: 13),
    //             child: SvgPicture.asset(
    //               widget.prefixIconSvgPath!,
    //               color: Theme.of(context).colorScheme.onSurface,
    //             ),
    //           )
    //         : null,
    //     prefixIconColor: Theme.of(context).colorScheme.onSurface,
    //     contentPadding: widget.contentPadding ??
    //         EdgeInsets.only(
    //           left: widget.prefixIconSvgPath == null ? 21 : 0,
    //           top: 20,
    //           bottom: 20,
    //           right: 20,
    //         ),
    //     enabledBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Color(0x00000000), width: 1),
    //       borderRadius: widget.borderRadius ?? Constants.borderRadius50,
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //           color: const Color(0xFFFFFFFF).withOpacity(0.3), width: 1),
    //       borderRadius: widget.borderRadius ?? Constants.borderRadius50,
    //     ),
    //     disabledBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //           color: const Color.fromARGB(255, 199, 199, 199).withOpacity(0.12),
    //           width: 1),
    //       borderRadius: widget.borderRadius ?? Constants.borderRadius50,
    //     ),
    //     errorBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //           color: Theme.of(context).colorScheme.error.withOpacity(0.5),
    //           width: 1),
    //       borderRadius: widget.borderRadius ?? Constants.borderRadius50,
    //     ),
    //     focusedErrorBorder: OutlineInputBorder(
    //       borderSide:
    //           BorderSide(color: Theme.of(context).colorScheme.error, width: 1),
    //       borderRadius: widget.borderRadius ?? Constants.borderRadius50,
    //     ),
    //     errorStyle: TextStyle(
    //         color: Theme.of(context).colorScheme.error,
    //         fontSize: 15,
    //         overflow: TextOverflow.fade),
    //     filled: widget.enabled == false ? false : true,
    //     fillColor: Theme.of(context).colorScheme.primaryContainer,
    //   ),
    //   hint: widget.hint ?? const Text("Selecciona una opción"),
    //   icon: const Icon(Icons.arrow_drop_down_rounded),
    //   onChanged: (List<String> value) {
    //     // This is called when the user selects an item.
    //     setState(() {
    //       selectedValues = value;
    //     });
    //     widget.onChanged(value);
    //   },
    //   options: widget.options,
    //   selectedValues: selectedValues,
    //   // whenEmpty: "Triggers del reto",
    // );
  }
}
