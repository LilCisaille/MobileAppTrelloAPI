import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/auth_service.dart';
import 'package:trelltech/components/custom_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/logo.png')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onDoubleTap: () => {
                context.go('/debug'),
              },
              child: Image.asset('assets/images/title.png'),
            ),
            const FractionallySizedBox(
              widthFactor: 0.8,
              child: Text(
                'manage your projects & teams anytime, anywhere',
                style: TextStyle(
                  fontFamily: 'LexendExa',
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset('assets/images/menu.png', height: 200),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: CustomButton(
                iconName: Icons.star,
                text: "get started",
                onPressed: () =>
                    context.read<Auth>().signUp().then((webView) => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                    title: const Text('TrailTech Sign-up')),
                                body: WebViewWidget(controller: webView),
                              ),
                            ),
                          ),
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
