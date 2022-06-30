import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class OutlinedCard extends StatelessWidget {
  const OutlinedCard({Key? key, required this.child, this.padding})
      : super(key: key);
  final Widget child;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: Constants.borderRadius18,
          border: Border.all(color: Colors.white.withOpacity(0.20))),
      child: child,
    );
  }
}
