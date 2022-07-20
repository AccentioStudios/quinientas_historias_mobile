import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/ui/widgets/big_button.dart';

import '../../utils/constants.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
    this.iconSvgPath,
    required this.title,
    required this.content,
    this.btnOnTap,
    this.btnLabel,
    this.secondaryBtnOnTap,
    this.secondaryBtnLabel,
  }) : super(key: key);
  final String? iconSvgPath;
  final String title;
  final String content;
  final Function? btnOnTap;
  final String? btnLabel;
  final Function? secondaryBtnOnTap;
  final String? secondaryBtnLabel;

  @override
  Widget build(BuildContext context) {
    TextStyle header1Style =
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    TextStyle contentStyle = const TextStyle(fontSize: 16);

    return SizedBox(
      height: 320,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.space21, vertical: Constants.space30),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: iconSvgPath != null
                  ? SvgPicture.asset(
                      iconSvgPath!,
                      width: 50,
                    )
                  : SvgPicture.asset(
                      'assets/icons/information-circle-outline-icon.svg',
                      width: 50,
                    ),
            ),
            const SizedBox(height: Constants.space16),
            Text(
              title,
              style: header1Style,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Constants.space21),
            Text(
              content,
              style: contentStyle,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: BigButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    onPressed: () {
                      if (btnOnTap != null) {
                        btnOnTap!();
                        return;
                      }
                      return Navigator.of(context).pop(true);
                    },
                    text: btnLabel ?? 'Ok',
                  ),
                ),
                if (secondaryBtnLabel != null)
                  const SizedBox(width: Constants.space16),
                if (secondaryBtnLabel != null)
                  Expanded(
                    flex: 1,
                    child: BigButton(
                      filled: false,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 16),
                      onPressed: () {
                        if (secondaryBtnOnTap != null) {
                          secondaryBtnOnTap!();
                          return;
                        }
                        return Navigator.of(context).pop(false);
                      },
                      text: secondaryBtnLabel,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
