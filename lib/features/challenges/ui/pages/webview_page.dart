import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/data/entities/dashboard_entity.dart';

class ChallengesMinigameWebView extends StatefulWidget with SheetMessages {
  const ChallengesMinigameWebView({
    super.key,
    required this.id,
    required this.url,
    required this.name,
    required this.description,
    this.type = 'minigame',
  });

  final int id;
  final String name;
  final String description;
  final String url;
  final String type;

  // final ChallengeSar challenge;

  @override
  State<ChallengesMinigameWebView> createState() =>
      _ChallengesMinigameWebViewState();
}

class _ChallengesMinigameWebViewState extends State<ChallengesMinigameWebView> {
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _webViewController?.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 85,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _webViewController?.reload();
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
                  child: SvgPicture.asset(getChallengeIcon(widget.type))),
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
      body: WebView(
          initialUrl: 'about:blank',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) async {
            _webViewController = webViewController;
            _webViewController?.loadRequest(
              WebViewRequest(
                  uri: Uri.parse(widget.url), method: WebViewRequestMethod.get),
            );
          },
          javascriptChannels: <JavascriptChannel>{
            JavascriptChannel(
              name: 'messageHandler',
              onMessageReceived: (JavascriptMessage message) {
                print("message from the web view=\"${message.message}\"");
                final script =
                    "document.getElementById('value').innerText=\"${message.message}\"";
                _webViewController?.runJavascript(script);
                print("js from flutter run");
              },
            )
          }),
    );
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
