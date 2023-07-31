import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/ui/widgets/big_button.dart';
import 'package:quinientas_historias/core/ui/widgets/padding_column.dart';

import '../../utils/constants.dart';

class MessagesBottomSheet extends StatefulWidget {
  const MessagesBottomSheet({
    super.key,
    this.controller,
    this.iconSvgPath,
    this.iconColor,
    required this.title,
    required this.content,
    this.contentBuilder,
    this.btnOnTap,
    this.btnLabel,
    this.secondaryBtnOnTap,
    this.secondaryBtnLabel,
    this.height = 320,
    this.compact = false,
    this.withoutButtons = false,
  });
  final String? iconSvgPath;
  final Color? iconColor;
  final String title;
  final String content;
  final Widget Function(BuildContext)? contentBuilder;
  final Function? btnOnTap;
  final String? btnLabel;
  final Function? secondaryBtnOnTap;
  final String? secondaryBtnLabel;
  final double height;
  final CustomBottomSheetController? controller;
  final bool compact;
  final bool withoutButtons;

  factory MessagesBottomSheet.compact({
    required String title,
    String? iconSvgPath,
    Widget Function(BuildContext)? contentBuilder,
    String? btnLabel,
    Function? btnOnTap,
    Function? secondaryBtnOnTap,
    String? secondaryBtnLabel,
    CustomBottomSheetController? controller,
    double height = 320,
    bool withoutButtons = false,
  }) {
    return MessagesBottomSheet(
      iconSvgPath: iconSvgPath,
      contentBuilder: contentBuilder,
      title: title,
      content: '',
      btnLabel: btnLabel,
      btnOnTap: btnOnTap,
      secondaryBtnOnTap: secondaryBtnOnTap,
      secondaryBtnLabel: secondaryBtnLabel,
      controller: controller,
      height: height,
      compact: true,
      withoutButtons: withoutButtons,
    );
  }

  @override
  State<MessagesBottomSheet> createState() => _MessagesBottomSheetState();
}

class _MessagesBottomSheetState extends State<MessagesBottomSheet> {
  TextStyle headerStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle headerCompactStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle contentStyle = const TextStyle(fontSize: 16);

  @override
  void initState() {
    if (widget.controller != null) {
      widget.controller!.close$.addListener(() {
        return Navigator.of(context).pop(widget.controller!.close$);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.close$.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.viewInsetsOf(context),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.compact) _compactHeader() else _header(),
          widget.contentBuilder != null
              ? widget.contentBuilder!(context)
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.space21),
                  child: Text(
                    widget.content,
                    style: contentStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
          const SizedBox(height: Constants.space30),
          if (!widget.withoutButtons) _buttons(),
        ],
      ),
    );
  }

  _buttons() => Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.space21, vertical: Constants.space16),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 50,
                child: BigButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  onPressed: () {
                    if (widget.btnOnTap != null) {
                      widget.btnOnTap!();
                      return;
                    }
                    return Navigator.of(context).pop(true);
                  },
                  text: widget.btnLabel ?? 'Ok',
                ),
              ),
            ),
            if (widget.secondaryBtnLabel != null)
              const SizedBox(width: Constants.space16),
            if (widget.secondaryBtnLabel != null)
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 50,
                  child: BigButton(
                    filled: false,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    onPressed: () {
                      if (widget.secondaryBtnOnTap != null) {
                        widget.secondaryBtnOnTap!();
                        return;
                      }
                      return Navigator.of(context).pop(false);
                    },
                    text: widget.secondaryBtnLabel,
                  ),
                ),
              ),
          ],
        ),
      );

  _compactHeader() => Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: Constants.space21),
                SizedBox(
                  height: 24,
                  child: widget.iconSvgPath != null
                      ? SvgPicture.asset(
                          widget.iconSvgPath!,
                          width: 24,
                          color: widget.iconColor,
                        )
                      : SvgPicture.asset(
                          'assets/icons/information-circle-outline-icon.svg',
                          width: 24,
                          color: widget.iconColor,
                        ),
                ),
                const SizedBox(width: Constants.space12),
                Text(
                  widget.title,
                  style: headerCompactStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: Constants.space21),
              ],
            ),
          ),
          // divisor line
          Container(
            height: 1.0,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.08),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      );

  _header() => PaddingColumn(
        padding: const EdgeInsets.only(
          left: Constants.space21,
          right: Constants.space21,
          top: Constants.space21,
        ),
        children: [
          SizedBox(
            height: 50,
            child: widget.iconSvgPath != null
                ? SvgPicture.asset(
                    widget.iconSvgPath!,
                    width: 50,
                    color: widget.iconColor,
                  )
                : SvgPicture.asset(
                    'assets/icons/information-circle-outline-icon.svg',
                    width: 50,
                    color: widget.iconColor,
                  ),
          ),
          const SizedBox(height: Constants.space16),
          Text(
            widget.title,
            style: headerStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Constants.space21),
        ],
      );
}

class CustomBottomSheetController {
  ValueNotifier<bool?> close$ = ValueNotifier(null);

  void closeSheet(bool? result) {
    close$.value = result;
  }
}
