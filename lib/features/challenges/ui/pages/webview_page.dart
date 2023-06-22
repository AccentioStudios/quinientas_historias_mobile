import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/integrations/platform_environments.dart';
import '../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/data/entities/dashboard_entity.dart';

import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

class ChallengesMinigameWebView extends StatefulWidget with SheetMessages {
  const ChallengesMinigameWebView({
    super.key,
    required this.userId,
    this.storyId,
    required this.id,
    required this.url,
    required this.name,
    required this.description,
    this.type = 'minigame',
    this.testMode = 'false',
    this.useHttps,
  });

  final String userId;
  final String? storyId;
  final int id;
  final String name;
  final String description;
  final String url;
  final String type;
  final String? testMode;
  final bool? useHttps;

  // final ChallengeSar challenge;

  @override
  State<ChallengesMinigameWebView> createState() =>
      _ChallengesMinigameWebViewState();
}

class _ChallengesMinigameWebViewState extends State<ChallengesMinigameWebView> {
  late final WebViewController _controller;
  int loadingProgress = 0;
  // create a private variable with the useHttps widget value as default
  bool currentHttpsSwitch = PlatformEnvironment.https;
  Uri? _uri; // Url with query paremeters

  @override
  void initState() {
    super.initState();
    currentHttpsSwitch =
        widget.useHttps != null ? widget.useHttps! : PlatformEnvironment.https;
    // construct url with query parameters
    buildCurrentUri();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF101C29))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          debugPrint('WebView is loading (progress : $progress%)');
          setState(() {
            loadingProgress = progress;
          });
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint('''
          Page resource error:
          code: ${error.errorCode}
          description: ${error.description}
          errorType: ${error.errorType}
          isForMainFrame: ${error.isForMainFrame}
        ''');
        },
      ))
      ..loadRequest(_uri!, method: LoadRequestMethod.get)
      ..addJavaScriptChannel('messageHandler',
          onMessageReceived: onChallengeEnded);

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features
    _controller = controller;
  }

  @override
  void dispose() {
    _controller.clearCache();
    super.dispose();
  }

  void buildCurrentUri() {
    _uri = buildUri(
        widget.url.replaceAll('https://', '').replaceAll('http://', ''),
        {
          'userId': widget.userId,
          if (widget.testMode == 'true') 'testMode': widget.testMode!,
          if (widget.storyId != null) 'storyId': widget.storyId.toString(),
        },
        https: currentHttpsSwitch);
  }

  Uri buildUri(String url, Map<String, dynamic>? queryParameters,
      {bool? https}) {
    try {
      // override all if http parameter is not null
      // other we use the environment variable to determine the protocol
      final uri = Uri.parse(url);
      final bool useHttps = https ?? PlatformEnvironment.https;

      if (useHttps) {
        return Uri.https(uri.host, uri.path, queryParameters);
      }
      return Uri.http(uri.host, uri.path, queryParameters);
    } catch (error) {
      rethrow;
    }
  }

  onChallengeEnded(JavaScriptMessage message) {
    if (kDebugMode) {
      print("Challenge ended: ${message.message}");
    }
    if (message.message == 'true') {
      AutoRouter.of(context).pop(true);
      return;
    }
    AutoRouter.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: widget.testMode == 'true'
            ? FloatingActionButton.extended(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                label: Text(currentHttpsSwitch ? 'HTTPS' : 'HTTP',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        )),
                tooltip: 'Cambiar entre HTTP y HTTPS',
                icon: Icon(
                  currentHttpsSwitch ? Icons.https : Icons.http,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                onPressed: () {
                  setState(() {
                    currentHttpsSwitch = !currentHttpsSwitch;
                    buildCurrentUri();
                    _controller.loadRequest(_uri!);
                  });
                })
            : null,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(58),
          child: Stack(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                leadingWidth: 85,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      _controller.reload();
                    },
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.help_outline),
                    onPressed: () {
                      widget.showMessage(
                        context,
                        iconSvgPath: getChallengeIcon(widget.type),
                        content:
                            'Juega libremente y suma puntos adicionales para el torneo.\n\nEste reto está desarrollado por terceros y si tienes algún inconveniente, puedes reportarlo haciendo clic en el botón de abajo.',
                        title: 'Esto es un minijuego de 500Historias',
                        secondaryBtnLabel: 'Reportar inconveniente',
                        secondaryBtnOnTap: () {
                          reportChallenge(widget.name, widget.id);
                        },
                      );
                    },
                    label: const Text('Ayuda'),
                  ),
                ],
                leading: Flex(
                  direction: Axis.horizontal,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: Constants.space12),
                      child: SizedBox(
                          child:
                              SvgPicture.asset(getChallengeIcon(widget.type))),
                    ),
                  ],
                ),
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.description,
                      style: const TextStyle(fontSize: 13),
                    )
                    // Text(
                    //   Uri.parse(widget.url).authority.toString(),
                    //   style: const TextStyle(fontSize: 13),
                    // )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: loadingProgress == 100 ? 0.0 : 1.0,
                  child: LinearProgressIndicator(
                    value: loadingProgress / 100,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: WebViewWidget(controller: _controller));
  }

  String getChallengeIcon(String type) {
    if (type == ChallengeType.minigame.name) {
      return 'assets/icons/challenge-minigame-outline-icon.svg';
    }
    if (type == ChallengeType.questions.name) {
      return 'assets/icons/challenge-questions-outline-icon.svg';
    }

    return 'assets/icons/challenge-steps-outline-icon.svg';
  }

  void reportChallenge(String name, int id) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

// ···
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'hello@500historias.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Reportar un problema con el minijuego "$name" ID: $id',
        'body': 'Quiero reportar un problema con el minijuego "$name."'
      }),
    );

    launchUrl(emailLaunchUri);
  }
}
