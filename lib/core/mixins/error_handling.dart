import 'package:flutter/material.dart';
import '../failures/failures.dart';

mixin ErrorHandling on Widget {
  void handleError(BuildContext context, Object error,
      {void Function()? navigate}) {
    // if (error is NetworkFailure) {
    //   _gotoNetworkError(context, navigate);
    //    return;
    // }
    if (error is CommonFailure) {
      _gotoCommonError(context, error, navigate);
      return;
    }

    _gotoCommonError(
      context,
      CommonFailure(''),
      navigate,
    );
  }

  // void _gotoNetworkError(BuildContext context, [void Function()? navigate]) {
  //   final AppLocalizationsData intl = context.localizations;
  //   final String title = intl.error.network.title;
  //   final String message = intl.error.network.message;
  //   final String button = intl.error.network.button;
  //   Navigator.of(context, rootNavigator: true)
  //       .push<void>(MaterialPageRoute<void>(
  //           builder: (BuildContext context) => ErrorMessagePage(
  //               title: title,
  //               subtitle: message,
  //               textButton: button,
  //               onPressed: () {
  //                 navigate ??= () => Navigator.of(context).pop();
  //                 navigate?.call();
  //               },
  //               )));
  // }

  void _gotoCommonError(BuildContext context, CommonFailure error,
      [void Function()? navigate]) {
    Navigator.of(context, rootNavigator: true).push<void>(
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const Text("Error screen :)")));
  }

  // void _contactSupport(BuildContext context, [void Function()? navigate]) {
  //   final Responsive responsive = Responsive.of(context);
  //   final AppLocalizationsData intl = context.localizations;
  //   final String span1 = intl.error.contactSupportSpan1;
  //   final String span2 = intl.error.contactSupportSpan2;
  //   final String contactUs = intl.error.contactUs;
  //   final String goBackHome = intl.error.contactSupportGoBackHome;

  //   showGkErrorMessage(
  //       context,
  //       GKMessageRedPage(
  //           iconPath: 'assets/images/error/icon_phone_alert.svg',
  //           gkInlineLabel: GKInlineLabel(spans: <GKLabelSpan>[
  //             GKLabelSpan(span1,
  //                 color: ColorPalette.white,
  //                 type: GKLabelSpanType.bold,
  //                 fontSize: responsive.dp(3.5)),
  //             GKLabelSpan('\n\n$span2',
  //                 color: ColorPalette.white, fontSize: responsive.dp(2.5))
  //           ]),
  //           linkText: goBackHome,
  //           linkOnPressed: () => _navigateToHome(context),
  //           buttonText: contactUs,
  //           onPressed: () {
  //             _callToSupport();
  //             if (navigate != null) {
  //               navigate();
  //             } else {
  //               _navigateToHome(context);
  //             }
  //           }));
  // }

}

class ErrorMessagePage extends StatelessWidget {
  const ErrorMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
