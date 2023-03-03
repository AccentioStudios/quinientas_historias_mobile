import 'package:flutter/material.dart';

import '../failures/failures.dart';
import '../failures/status_codes.dart';
import '../helpers/secure_storage_helper.dart';
import '../routes/routes.dart';
import '../ui/pages/common_page_layout.dart';

mixin ErrorHandling on Widget {
  Future<T?> _showErrorMessage<T>(BuildContext context, Widget page) {
    return Navigator.of(context, rootNavigator: true)
        .push<T>(MaterialPageRoute<T>(builder: (context) => page));
  }

  Future<T?> handleError<T>(
    BuildContext context,
    HttpFailure httpFailure, {
    String? btnLabel,
    void Function()? onTap,
    String? linkBtnLabel,
    void Function()? linkBtnOnTap,
  }) async {
    switch (httpFailure.statusCode) {
      case StatusCodes.networkError:
        return _gotoNetworkError<T>(context, onTap);
      case StatusCodes.unauthorized:
        return _gotoAuthError<T>(context, httpFailure.message);
      case StatusCodes.badRequest:
        return _gotoBadRequestError<T>(
          context,
          btnLabel: btnLabel,
          onTap: onTap,
          linkBtnLabel: linkBtnLabel,
          linkBtnOnTap: linkBtnOnTap,
        );
      default:
        return _gotoCommonError<T>(
          context,
          httpFailure,
          btnLabel: btnLabel,
          onTap: onTap,
          linkBtnLabel: linkBtnLabel,
          linkBtnOnTap: linkBtnOnTap,
        );
    }
  }

  Future<T?> _gotoCommonError<T>(
    BuildContext context,
    HttpFailure httpFailure, {
    String? btnLabel,
    void Function()? onTap,
    String? linkBtnLabel,
    void Function()? linkBtnOnTap,
  }) {
    return _showErrorMessage<T>(
        context,
        CommonPageLayout(
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
        CommonPageLayout(
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
              SecureStorageHelper.deleteAll();
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
        CommonPageLayout(
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

  Future<T?> _gotoAuthError<T>(BuildContext context, FailureType? errorType) {
    if (errorType == FailureType.userIsNotActive) {
      return _showErrorMessage<T>(
          context,
          CommonPageLayout(
            headline: 'Usuario desactivado',
            message:
                'Esta cuenta esta desactivada. Si crees que esto fué un error entra en contacto con nosotros.',
            svgImagePath: 'assets/images/hand-left-image.svg',
            btnLabel: 'Entiendo',
            onBtnTap: () {
              SecureStorageHelper.deleteAll();
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(Routes.login);
            },
          ));
    }
    if (errorType == FailureType.userIsBanned) {
      return _showErrorMessage<T>(
          context,
          CommonPageLayout(
            headline: 'Tu cuenta ha sido bloqueada',
            message:
                'Esta cuenta esta bloqueada. Esto normalmente sucede por comportamiento indebido.\n\nSi crees que esto fué un error entra en contacto con nosotros.',
            svgImagePath: 'assets/images/hand-left-image.svg',
            btnLabel: 'Entiendo',
            onBtnTap: () {
              SecureStorageHelper.deleteAll();
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(Routes.login);
            },
          ));
    }
    return _showErrorMessage<T>(
        context,
        CommonPageLayout(
          headline: 'You shall not pass!!',
          message:
              'No reconocemos que tengas acceso aquí, intenta iniciar sesión nuevamente con los permisos correctos.',
          svgImagePath: 'assets/images/hand-left-image.svg',
          btnLabel: 'Volver',
          linkBtnLabel: 'Cerrar sesión',
          linkBtnOnTap: () {
            SecureStorageHelper.deleteAll();
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
          },
        ));
  }

  Future<T?> _gotoInviteNotFoundError<T>(
    BuildContext context, {
    String? btnLabel,
    void Function()? onTap,
  }) {
    return _showErrorMessage<T>(
        context,
        CommonPageLayout(
          headline: 'La invitación no existe',
          message:
              'Parece que has recibido una invitación que no existe. Revisa nuevamente tu e-mail en busqueda de una más nueva.',
          btnLabel: 'Entiendo',
          svgImagePath: 'assets/images/broken-invitation-image.svg',
          onBtnTap: () {
            Navigator.of(context, rootNavigator: true)
                .popUntil((route) => route.isFirst);
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
          },
        ));
  }

  // Future<T?> _gotoUserIsAlreadyRegisteredError<T>(
  //   BuildContext context, {
  //   String? btnLabel,
  //   void Function()? onTap,
  // }) {
  //   return _showErrorMessage<T>(
  //       context,
  //       CommonPageLayout(
  //         headline: 'El usuario parece que ya existe',
  //         message:
  //             'Intenta iniciar sesion usando el mismo email que intentaste registrar. En caso de que no te acuerdes de tu contraseña puedes restablecer tu contraseña.',
  //         btnLabel: 'Iniciar sesión',
  //         svgImagePath: 'assets/images/broken-invitation-image.svg',
  //         onBtnTap: () {
  //           Navigator.of(context, rootNavigator: true)
  //               .popUntil((route) => route.isFirst);
  //           Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
  //         },
  //         linkBtnLabel: 'Restablecer Contraseña',
  //         linkBtnOnTap: () {
  //           Navigator.of(context, rootNavigator: true)
  //               .popUntil((route) => route.isFirst);
  //           Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
  //           AuthProvider.openIForgot(context);
  //         },
  //       ));
  // }
}
