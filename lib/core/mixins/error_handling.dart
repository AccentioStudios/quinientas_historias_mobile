import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../failures/auth_failure.dart';
import '../failures/bad_request_failure.dart';
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
      return _gotoCommonError<T>(
        context,
        CommonFailure(),
        btnLabel: btnLabel,
        onTap: onTap,
        linkBtnLabel: linkBtnLabel,
        linkBtnOnTap: linkBtnOnTap,
      );
    }

    if (error is AuthFailure) {
      return _gotoAuthError<T>(context, error.error);
    }

    if (error is BadRequestFailure) {
      return _gotoBadRequestError<T>(
        context,
        btnLabel: btnLabel,
        onTap: onTap,
        linkBtnLabel: linkBtnLabel,
        linkBtnOnTap: linkBtnOnTap,
      );
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
              return onTap();
            }
            Navigator.of(context, rootNavigator: true).pop(true);
          },
          linkBtnLabel: linkBtnLabel,
          linkBtnOnTap: linkBtnOnTap,
        ));
  }

  Future<T?> _gotoNetworkError<T>(BuildContext context,
      [void Function()? onTap]) {
    return _showErrorMessage<T>(
        context,
        ErrorPage(
            headline: 'What!?',
            message:
                'Hay un problema de conexion a internet. Parece que alguién se llevó la conexión a internet ☹',
            svgImagePath: 'assets/images/wifi-error-image.svg',
            btnLabel: 'Intentar nuevamente',
            onBtnTap: () {
              if (onTap != null) {
                onTap();
                return;
              }
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            linkBtnLabel: 'Cerrar Sesión',
            linkBtnOnTap: () {
              const secureStorage = FlutterSecureStorage();
              secureStorage.deleteAll();
              Navigator.of(context, rootNavigator: true)
                  .popUntil((route) => route.isFirst);
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(Routes.login);
            }));
  }

  Future<T?> _gotoBadRequestError<T>(
    BuildContext context, {
    String? btnLabel,
    void Function()? onTap,
    String? linkBtnLabel,
    void Function()? linkBtnOnTap,
  }) {
    return _showErrorMessage<T>(
        context,
        ErrorPage(
          headline: 'Hubo un error en tu solicitud',
          message: 'Verifica los datos que mandaste e intenta nuevamente.',
          btnLabel: btnLabel,
          onBtnTap: () {
            if (onTap != null) {
              return onTap();
            }
            Navigator.of(context, rootNavigator: true).pop(true);
          },
          linkBtnLabel: linkBtnLabel,
          linkBtnOnTap: linkBtnOnTap,
        ));
  }

  Future<T?> _gotoAuthError<T>(
      BuildContext context, AuthFailureType? errorType) {
    if (errorType == AuthFailureType.mustUpdatePassword) {
      return _showErrorMessage<T>(
          context,
          ErrorPage(
            headline: 'Es necesario que restaures tu contraseña',
            message:
                'Para poder iniciar sesion es necesario que crees una nueva contraseña.',
            svgImagePath: 'assets/images/new-pass-image.svg',
            btnLabel: 'Volver',
            onBtnTap: () {
              // Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(Routes.login);
            },
          ));
    }
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
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
          },
        ));
  }
}
