import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/failures/auth_failure.dart';
import '../failures/common_failure.dart';
import '../failures/failures.dart';
import '../routes/routes.dart';
import '../ui/pages/error_page.dart';

mixin ErrorHandling on Widget {
  Future<T?> _showErrorMessage<T>(BuildContext context, Widget page) {
    return Navigator.of(context, rootNavigator: true)
        .push<T>(MaterialPageRoute<T>(builder: (context) => page));
  }

  Future<T?> handleError<T>(
    BuildContext context,
    Object error, {
    String? btnLabel,
    void Function()? onTap,
    String? linkBtnLabel,
    void Function()? linkBtnOnTap,
  }) async {
    if (error is NetworkFailure) {
      return _gotoNetworkError<T>(context, onTap);
    }
    if (error is CommonFailure) {
      return _gotoCommonError<T>(context, error, onTap: onTap);
    }

    if (error is AuthFailure) {
      return _gotoAuthError<T>(context);
    }

    return _gotoCommonError<T>(
      context,
      CommonFailure(),
      btnLabel: btnLabel,
      onTap: onTap,
      linkBtnLabel: linkBtnLabel,
      linkBtnOnTap: linkBtnOnTap,
    );
  }

  Future<T?> _gotoCommonError<T>(
    BuildContext context,
    CommonFailure error, {
    String? btnLabel,
    void Function()? onTap,
    String? linkBtnLabel,
    void Function()? linkBtnOnTap,
  }) {
    return _showErrorMessage<T>(
        context,
        ErrorPage(
          btnLabel: btnLabel,
          onBtnTap: () {
            if (onTap != null) {
              onTap();
            }
            Navigator.of(context).pop(true);
          },
          linkBtnLabel: linkBtnLabel,
          linkBtnOnTap: linkBtnOnTap,
        ));
  }

  Future<T?> _gotoNetworkError<T>(BuildContext context,
      [void Function()? onTap]) {
    return Navigator.of(context, rootNavigator: true).push<T>(
        MaterialPageRoute<T>(
            builder: (BuildContext context) => const Text("Network Error :)")));
  }

  Future<T?> _gotoAuthError<T>(BuildContext context) {
    return _showErrorMessage<T>(
        context,
        ErrorPage(
          headline: 'You shall not pass!!',
          message:
              'No reconocemos que tengas acceso aquí, intenta iniciar sesión nuevamente con los permisos correctos.',
          svgImagePath: 'assets/images/hand-left-image.svg',
          btnLabel: 'Iniciar sesión',
          onBtnTap: () {
            // Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushNamed(Routes.login);
          },
        ));
  }
}
