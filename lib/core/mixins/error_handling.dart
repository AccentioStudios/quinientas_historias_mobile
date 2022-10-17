import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quinientas_historias/core/helpers/secure_storage_helper.dart';
import 'package:quinientas_historias/features/auth/auth_provider.dart';

import '../failures/failures.dart';
import '../failures/status_codes.dart';
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
    if (httpFailure.statusCode == StatusCodes.networkError) {
      return _gotoNetworkError<T>(context, onTap);
    }

    if (httpFailure.statusCode == StatusCodes.unauthorized) {
      return _gotoAuthError<T>(context, httpFailure.error);
    }

    if (httpFailure.statusCode == StatusCodes.badRequest) {
      if (httpFailure.error == FailureType.userIsAlreadyRegistered) {
        return _gotoUserIsAlreadyRegisteredError<T>(context);
      }
      return _gotoBadRequestError<T>(
        context,
        btnLabel: btnLabel,
        onTap: onTap,
        linkBtnLabel: linkBtnLabel,
        linkBtnOnTap: linkBtnOnTap,
      );
    }

    if (httpFailure.error == FailureType.inviteNotFound) {
      return _gotoInviteNotFoundError<T>(context);
    }

    return _gotoCommonError<T>(
      context,
      HttpFailure(),
      btnLabel: btnLabel,
      onTap: onTap,
      linkBtnLabel: linkBtnLabel,
      linkBtnOnTap: linkBtnOnTap,
    );
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
    if (errorType == FailureType.mustUpdatePassword) {
      return _showErrorMessage<T>(
          context,
          CommonPageLayout(
            headline: 'Es necesario que restaures tu contraseña',
            message:
                'Para poder iniciar sesion es necesario que crees una nueva contraseña.',
            svgImagePath: 'assets/images/new-pass-image.svg',
            btnLabel: 'Volver',
            onBtnTap: () {
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

  Future<T?> _gotoUserIsAlreadyRegisteredError<T>(
    BuildContext context, {
    String? btnLabel,
    void Function()? onTap,
  }) {
    return _showErrorMessage<T>(
        context,
        CommonPageLayout(
          headline: 'El usuario parece que ya existe',
          message:
              'Intenta iniciar sesion usando el mismo email que intentaste registrar. En caso de que no te acuerdes de tu contraseña puedes restablecer tu contraseña.',
          btnLabel: 'Iniciar sesión',
          svgImagePath: 'assets/images/broken-invitation-image.svg',
          onBtnTap: () {
            Navigator.of(context, rootNavigator: true)
                .popUntil((route) => route.isFirst);
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
          },
          linkBtnLabel: 'Restablecer Contraseña',
          linkBtnOnTap: () {
            Navigator.of(context, rootNavigator: true)
                .popUntil((route) => route.isFirst);
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
            AuthProvider.openIForgot(context);
          },
        ));
  }
}
