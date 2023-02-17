import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key, required this.url});

  final String url;

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
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
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inicia sesión en 500Historias...',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 2),
            Text(
              Uri.parse(widget.url).authority.toString(),
              style: const TextStyle(fontSize: 13),
            )
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
}
