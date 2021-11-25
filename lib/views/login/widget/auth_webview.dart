import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthWebView extends StatefulWidget {
  const AuthWebView({Key? key}) : super(key: key);

  @override
  AuthWebViewState createState() => AuthWebViewState();
}

class AuthWebViewState extends State<AuthWebView> {
  int _loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
  }

  @override
  Widget build(BuildContext context) {
    final clientId = dotenv.get("CLIENT_ID");
    final redirectUri = dotenv.get("REDIRECT_URL");

    final url = Uri.https('www.reddit.com', '/api/v1/authorize.compact', {
      'client_id': clientId,
      'response_type': 'code',
      'state': 'RANDOM',
      'redirect_uri': redirectUri,
      'duration': 'permanent',
      'scope':
          'identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread',
    });

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text('Authentication Page'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          _loadingProgress != 100
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        userAgent:
            'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.50 Mobile Safari/537.36',
        initialUrl: url.toString(),
        navigationDelegate: (navReg) {
          if (navReg.url.contains('code=')) {
            Navigator.maybePop<String>(context, navReg.url);
          }
          return NavigationDecision.navigate;
        },
        onWebViewCreated: (controller) async {
          log((await controller.currentUrl()).toString());
        },
        onProgress: (value) {
          setState(() {
            _loadingProgress = value;
          });
        },
      ),
    );
    //return Container();
  }
}
