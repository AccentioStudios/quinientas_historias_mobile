import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({
    Key? key,
    required this.wideScreenLayout,
    required this.narrowScreenLayout,
  }) : super(key: key);

  final Widget wideScreenLayout;
  final Widget narrowScreenLayout;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > Constants.wideScrenSize) {
          return wideScreenLayout;
        }
        return narrowScreenLayout;
      },
    );
  }
}
