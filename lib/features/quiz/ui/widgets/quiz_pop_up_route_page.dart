import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/utils/colors.dart';

import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/utils/constants.dart';

class QuizPopupRoute<T> extends PopupRoute<T> {
  QuizPopupRoute({
    required this.builder,
  });

  @override
  Color get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => 'QuizPopupRoute';

  final WidgetBuilder builder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final top = MediaQuery.paddingOf(context).top;
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.topCenter,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: backgroundDarkColor.withOpacity(0.8),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: PaddingColumn(
                padding:
                    EdgeInsets.only(top: top + 3, bottom: Constants.space16),
                children: [
                  const SizedBox(height: Constants.space41),
                  const Text(
                    "¡Veamos que recuerdas\nde la lectura!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  builder(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}
