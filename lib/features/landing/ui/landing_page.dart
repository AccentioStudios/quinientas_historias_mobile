import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_links/uni_links.dart';

import '../../../core/integrations/secure_storage_service.dart';
import '../../../core/integrations/remote_config_service.dart';
import '../../../core/mixins/error_handling.dart';
import '../../../core/routes/routes.dart';
import '../../../core/ui/pages/common_page_layout.dart';

class LandingPage extends StatefulWidget with ErrorHandling {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Uri? _initialUri;
  bool _initialURILinkHandled = false;
  late GlobalKey<NavigatorState> landingNavigatorKey;

  @override
  void initState() {
    landingNavigatorKey = GlobalKey<NavigatorState>();
    super.initState();
    initCheckings();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> _checkAccessToken() async {
    final String? secureStorage =
        await GetIt.I<SecureStorageService>().getAccessToken();
    final test = secureStorage != null;
    return test;
  }

  bool _checkMaintenanceMode() {
    final remoteConfig = RemoteConfigService.instance;
    final bool response = remoteConfig.getBool('maintenance_mode');
    return response;
  }

  Future<void> _initURIHandler() async {
    // 1

    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      // 2
      try {
        // 3
        final initialURI = await getInitialUri();
        // 4
        if (initialURI != null) {
          debugPrint("Initial URI received $initialURI");
          setState(() {
            _initialUri = initialURI;
          });
          _navigateToRouteFromDeepLink(initialURI);
        } else {
          debugPrint("Null Initial URI received");
        }
      } on PlatformException {
        // 5
        debugPrint("Failed to receive initial uri");
      } on FormatException catch (err) {
        // 6
        debugPrint('Malformed Initial URI received $err');
      }
    }
  }

  void _navigateToRouteFromDeepLink(Uri? uri) async {
    // if (uri != null) {
    //   if (uri.queryParameters.keys.contains('inviteId') &&
    //       uri.queryParameters.keys.contains('invitationCode')) {
    //     ReceivedInviteProvider.open(context,
    //         inviteId: int.tryParse(uri.queryParameters['inviteId'] ?? '0') ?? 0,
    //         email: uri.queryParameters['email'] ?? '',
    //         code: uri.queryParameters['invitationCode'] ?? '');
    //     return;
    //   }
    // }
    _navigateToNext();
    return;
  }

  Future<void> initCheckings() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_checkMaintenanceMode()) {
        Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
                builder: (context) => const CommonInfoPage(
                      headline: 'Volveremos pronto',
                      message:
                          'Nuestro equipo esta trabajando fuertemente\npara hacer todavia mejor tu experiencia, volveremos lo mas rápido posible!, lo prometemos.',
                      riveAnimationPath:
                          'assets/images/maintenance-animation.riv',
                      withoutBtns: true,
                    )));
        return;
      }

      await _initURIHandler();
      if (_initialUri != null) {
        return;
      }
      if (!mounted) return;

      _navigateToNext();
    });
  }

  void _navigateToNext() async {
    if (await _checkAccessToken()) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true)
          .popUntil((route) => route.isFirst);
      Navigator.of(context, rootNavigator: true)
          .pushReplacementNamed(Routes.homeNavigator);
    } else {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true)
          .popUntil((route) => route.isFirst);
      Navigator.of(context, rootNavigator: true)
          .pushReplacementNamed(Routes.login);
    }
  }
}
