import 'package:flutter/material.dart';
import '../failures/failures.dart';
import '../ui/pages/error_page.dart';

mixin ErrorHandling on Widget {
  Future<void> _showErrorMessage(BuildContext context, Widget page) {
    return Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute<void>(builder: (context) => page));
  }

  void handleError(BuildContext context, Object error,
      {void Function()? navigate}) {
    if (error is NetworkFailure) {
      _gotoNetworkError(context, navigate);
      return;
    }
    if (error is CommonFailure) {
      _gotoCommonError(context, error, navigate);
      return;
    }

    if (error is UnauthorizedFailure) {
      _gotoUnauthorizedError(context);
      return;
    }

    _gotoCommonError(
      context,
      CommonFailure(''),
      navigate,
    );
  }

  void _gotoCommonError(BuildContext context, CommonFailure error,
      [void Function()? navigate]) {
    _showErrorMessage(context, ErrorPage(
      onBtnTap: () {
        Navigator.of(context).pop();
      },
    ));
  }

  void _gotoNetworkError(BuildContext context, [void Function()? navigate]) {
    Navigator.of(context, rootNavigator: true).push<void>(
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const Text("Network Error :)")));
  }

  void _gotoUnauthorizedError(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push<void>(
        MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                const Text("Sesion/Login Error :)")));
  }
}

class ErrorMessagePage extends StatelessWidget {
  const ErrorMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}