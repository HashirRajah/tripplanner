import 'package:flutter/material.dart';
import 'package:tripplanner/screens/webview_screens/webview.dart';

class TravelInfoScreen extends StatelessWidget {
  const TravelInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const WebViewScreen(url: 'https://www.embassypages.com');
              },
            ));
          },
          child: const Text('WebView'),
        ),
      ),
    );
  }
}
