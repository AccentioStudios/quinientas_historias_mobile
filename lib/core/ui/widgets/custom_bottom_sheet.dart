import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/ui/widgets/big_button.dart';

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

  @override
  State<MessagesBottomSheet> createState() => _MessagesBottomSheetState();
}

class _MessagesBottomSheetState extends State<MessagesBottomSheet> {
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
    TextStyle header1Style =
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    TextStyle contentStyle = const TextStyle(fontSize: 16);

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.space21, vertical: Constants.space30),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
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
            style: header1Style,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Constants.space21),
          widget.contentBuilder != null
              ? widget.contentBuilder!(context)
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.space8),
                  child: Text(
                    widget.content,
                    style: contentStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
          const SizedBox(height: Constants.space30),
          Row(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 16),
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
        ],
      ),
    );
  }
}

class CustomBottomSheetController {
  ValueNotifier<bool?> close$ = ValueNotifier(null);

  void closeSheet(bool? result) {
    close$.value = result;
  }
}
