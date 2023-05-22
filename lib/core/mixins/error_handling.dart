import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quinientas_historias/core/routes/auto_router.dart';

import '../failures/failures.dart';
import '../failures/status_codes.dart';
import '../integrations/secure_storage_service.dart';
import '../ui/pages/common_page_layout.dart';

mixin ErrorHandling on Widget {
  Future<T?> _showErrorMessage<T>(BuildContext context, Widget page) {
    return Navigator.of(context)
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
          failureType: httpFailure.message,
          onTap: onTap,
          linkBtnLabel: linkBtnLabel,
          linkBtnOnTap: linkBtnOnTap,
        );
      case StatusCodes.notFound:
        return _gotoNotFoundError<T>(
          context,
          httpFailure.message,
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
        CommonInfoPage(
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
        CommonInfoPage(
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
              GetIt.I<SecureStorageService>().deleteAll();
              AutoRouter.of(context).push(AuthRoute());
            }));
  }

  Future<T?> _gotoBadRequestError<T>(
    BuildContext context, {
    String? btnLabel,
    FailureTypes? failureType,
    void Function()? onTap,
    String? linkBtnLabel,
    void Function()? linkBtnOnTap,
  }) {
    if (failureType == FailureTypes.existingUserLogin) {
      return _showErrorMessage<T>(
          context,
          CommonInfoPage(
            headline: 'Esta cuenta ya existe',
            message:
                'Ya existe una cuenta con este correo electrónico. Intenta iniciar sesión con tu contraseña.',
            btnLabel: 'Iniciar Sesión',
            svgImagePath: 'assets/images/broken-invitation-image.svg',
            onBtnTap: () async {
              if (!context.mounted) return;
              if (await GetIt.I<SecureStorageService>().getSessionData() !=
                  null) {
                // ignore: use_build_context_synchronously
                AutoRouter.of(context).push(const ShellRoute());
              } else {
                // ignore: use_build_context_synchronously
                AutoRouter.of(context).push(AuthRoute());
              }
            },
          ));
    }
    if (failureType == FailureTypes.invalidInvitationCode) {
      return _showErrorMessage<T>(
          context,
          CommonInfoPage(
            headline: 'Código de invitación inválido',
            message:
                'El código de invitación que ingresaste no es válido. Revisa nuevamente tu e-mail en busqueda de una más nueva.',
            btnLabel: 'Entiendo',
            svgImagePath: 'assets/images/broken-invitation-image.svg',
            onBtnTap: () async {
              if (!context.mounted) return;
              if (await GetIt.I<SecureStorageService>().getSessionData() !=
                  null) {
                // ignore: use_build_context_synchronously
                AutoRouter.of(context).push(const ShellRoute());
              } else {
                // ignore: use_build_context_synchronously
                AutoRouter.of(context).push(AuthRoute());
              }
            },
          ));
    }
    return _showErrorMessage<T>(
        context,
        CommonInfoPage(
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

  Future<T?> _gotoNotFoundError<T>(
    BuildContext context,
    FailureTypes? errorType, {
    String? btnLabel,
    void Function()? onTap,
    String? linkBtnLabel,
    void Function()? linkBtnOnTap,
  }) {
    if (errorType == FailureTypes.inviteNotFound) {
      return _showErrorMessage<T>(
          context,
          CommonInfoPage(
            headline: 'La invitación no existe',
            message:
                'Parece que has recibido una invitación que no existe. Revisa nuevamente tu e-mail en busqueda de una más nueva.',
            btnLabel: 'Entiendo',
            svgImagePath: 'assets/images/broken-invitation-image.svg',
            onBtnTap: () async {
              if (!context.mounted) return;
              if (await GetIt.I<SecureStorageService>().getSessionData() !=
                  null) {
                // ignore: use_build_context_synchronously
                AutoRouter.of(context).push(const ShellRoute());
              } else {
                // ignore: use_build_context_synchronously
                AutoRouter.of(context).push(AuthRoute());
              }
            },
          ));
    }
    return _showErrorMessage<T>(
        context,
        CommonInfoPage(
          headline: 'No encontramos lo que buscabas',
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

  Future<T?> _gotoAuthError<T>(BuildContext context, FailureTypes? errorType) {
    if (errorType == FailureTypes.inviteBelongToAnotherUser) {
      // The invitation is for another user
      return _showErrorMessage<T>(
          context,
          CommonInfoPage(
            headline: 'Invitación para otro usuario',
            message:
                'Esta invitación es para otro usuario. Si crees que esto fué un error entra en contacto con nosotros.',
            svgImagePath: 'assets/images/hand-left-image.svg',
            btnLabel: 'Entiendo',
            onBtnTap: () async {
              if (!context.mounted) return;
              if (await GetIt.I<SecureStorageService>().getSessionData() !=
                  null) {
                // ignore: use_build_context_synchronously
                AutoRouter.of(context).push(const ShellRoute());
              } else {
                // ignore: use_build_context_synchronously
                AutoRouter.of(context).push(AuthRoute());
              }
            },
          ));
    }

    if (errorType == FailureTypes.inviterDontBelongToTheTeam ||
        errorType == FailureTypes.inviterDontBelongToTheSchool) {
      return _showErrorMessage<T>(
          context,
          CommonInfoPage(
            headline:
                'No perteneces al equipo o escuela para invitar a este usuario',
            message:
                'No puedes invitar a este usuario porque no perteneces al equipo o escuela.',
            svgImagePath: 'assets/images/hand-left-image.svg',
            btnLabel: 'Entiendo',
            onBtnTap: () {
              AutoRouter.of(context).push(const ShellRoute());
            },
          ));
    }
    if (errorType == FailureTypes.userIsNotActive) {
      return _showErrorMessage<T>(
          context,
          CommonInfoPage(
            headline: 'Usuario desactivado',
            message:
                'Esta cuenta esta desactivada. Si crees que esto fué un error entra en contacto con nosotros.',
            svgImagePath: 'assets/images/hand-left-image.svg',
            btnLabel: 'Entiendo',
            onBtnTap: () {
              GetIt.I<SecureStorageService>().deleteAll();
              AutoRouter.of(context).push(AuthRoute());
            },
          ));
    }
    if (errorType == FailureTypes.userIsBanned) {
      return _showErrorMessage<T>(
          context,
          CommonInfoPage(
            headline: 'Tu cuenta ha sido bloqueada',
            message:
                'Esta cuenta esta bloqueada. Esto normalmente sucede por comportamiento indebido.\n\nSi crees que esto fué un error entra en contacto con nosotros.',
            svgImagePath: 'assets/images/hand-left-image.svg',
            btnLabel: 'Entiendo',
            onBtnTap: () {
              GetIt.I<SecureStorageService>().deleteAll();
              AutoRouter.of(context).push(AuthRoute());
            },
          ));
    }
    return _showErrorMessage<T>(
        context,
        CommonInfoPage(
          headline: 'You shall not pass!!',
          message:
              'No reconocemos que tengas acceso aquí, intenta iniciar sesión nuevamente con los permisos correctos.',
          svgImagePath: 'assets/images/hand-left-image.svg',
          btnLabel: 'Volver',
          onBtnTap: () {
            AutoRouter.of(context).pop(false);
            Navigator.of(context, rootNavigator: true).pop(false);
          },
          linkBtnLabel: 'Cerrar sesión',
          linkBtnOnTap: () {
            GetIt.I<SecureStorageService>().deleteAll();
            AutoRouter.of(context).push(AuthRoute());
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
