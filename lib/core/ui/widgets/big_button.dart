import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    Key? key,
    required this.onPressed,
    this.child,
    this.text,
    this.isLoading = false,
    // this.width,
    // this.height,
  }) : super(key: key);
  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final bool isLoading;
  // final double? width;
  // final double? height;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return primaryMutedColor;
          }
          return null;
        },
      ), shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((_) {
        return RoundedRectangleBorder(
          borderRadius: Constants.borderRadius50,
        );
      }), elevation: MaterialStateProperty.resolveWith<double?>((_) {
        return 0;
      })),
      onPressed: isLoading ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: SizedBox(
          height: 21,
          child: isLoading
              ? buildProgressIndicator()
              : text != null
                  ? buildTextOption()
                  : child,
        ),
      ),
    );
  }

  Center buildProgressIndicator() {
    return const Center(
        child: SizedBox(
      height: 21,
      width: 21,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.white,
      ),
    ));
  }

  Widget buildTextOption() {
    return Text(
      text ?? '',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
