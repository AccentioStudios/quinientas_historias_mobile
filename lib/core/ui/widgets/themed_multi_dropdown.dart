import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants.dart';

class ThemedMultiDropdown<T> extends StatefulWidget {
  const ThemedMultiDropdown({
    super.key,
    required this.onChanged,
    required this.items,
    this.borderRadius,
    this.suffix,
    this.contentPadding,
    this.errorText,
    this.enabled,
    this.prefixIconSvgPath,
    this.hint,
    this.validator,
    this.values,
  });

  final dynamic Function(List<T>) onChanged;
  final String? errorText;
  final Widget? suffix;
  final BorderRadius? borderRadius;
  final String? prefixIconSvgPath;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enabled;
  final List<MultDropdownMenuItem<T>> items;
  final Widget? hint;
  final String? Function(T?)? validator;
  final List<T>? values;
  @override
  State<ThemedMultiDropdown<T>> createState() => _ThemedMultiDropdownState<T>();
}

class _ThemedMultiDropdownState<T> extends State<ThemedMultiDropdown<T>> {
  @override
  void initState() {
    super.initState();
    selectedValues = widget.values ?? [];
  }

  List<T> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        DropdownButtonFormField<T>(
          onChanged: (dynamic value) {
            if (selectedValues.contains(value)) {
              setState(() {
                selectedValues.remove(value);
              });
              widget.onChanged(selectedValues);
            } else {
              setState(() {
                selectedValues.add(value);
              });
              widget.onChanged(selectedValues);
            }
          },
          // onChanged: (dynamic value) {
          //   // This is called when the user selects an item.
          //   setState(() {
          //     selectedValues = value.value;
          //   });
          //   widget.onChanged(value.value);
          // },
          // selectedValues: selectedValues,
          selectedItemBuilder: (context) {
            return widget.items
                .map((e) => DropdownMenuItem(
                      child: Container(),
                    ))
                .toList();
          },
          items: widget.items.map(
            (e) {
              return DropdownMenuItem<T>(
                  key: ObjectKey(e.value),
                  value: e.value,
                  child: Text(e.label));
            },
          ).toList(),
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
                  color: const Color.fromARGB(255, 199, 199, 199)
                      .withOpacity(0.12),
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
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error, width: 1),
              borderRadius: widget.borderRadius ?? Constants.borderRadius50,
            ),
            errorStyle: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 15,
                overflow: TextOverflow.fade),
            filled: widget.enabled == false ? false : true,
            fillColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          hint: widget.hint ?? const Text("Selecciona una opción"),
          icon: const Icon(Icons.arrow_drop_down_rounded),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: Constants.space16, right: Constants.space41),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...selectedValues.map((e) => Padding(
                      padding: const EdgeInsets.only(right: Constants.space8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedValues.remove(e);
                          });
                          widget.onChanged(selectedValues);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                widget.borderRadius ?? Constants.borderRadius50,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer
                                .withOpacity(0.2),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            e.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _SelectRow extends StatefulWidget {
  final Function(bool) onChange;
  final bool selected;
  final Widget child;

  const _SelectRow(
      {Key? key,
      required this.onChange,
      required this.selected,
      required this.child})
      : super(key: key);

  @override
  State<_SelectRow> createState() => _SelectRowState();
}

class _SelectRowState extends State<_SelectRow> {
  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChange(!_selected);
      },
      child: SizedBox(
        height: kMinInteractiveDimension,
        child: Row(
          children: [
            Checkbox(
                value: _selected,
                onChanged: (x) {
                  setState(() {
                    _selected = x!;
                  });
                  widget.onChange(x!);
                }),
            widget.child
          ],
        ),
      ),
    );
  }
}

class MultDropdownMenuItem<T> extends StatelessWidget {
  const MultDropdownMenuItem(
      {super.key, required this.value, required this.label});
  final T value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return DropdownMenuItem(
      value: value,
      child: Text(label),
    );
  }
}
