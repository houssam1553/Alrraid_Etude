import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class landingScreen extends StatefulWidget {
  @override
  State<landingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<landingScreen> {
  late final WebViewController controller;
  bool isLoading = true; // Flag to show the loading indicator

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                isLoading = true; // Show loader when the page starts loading
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                isLoading = false; // Hide loader when the page finishes loading
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://alrraid.com/fr'));
  }

  @override
  void dispose() {
    controller.clearCache(); // Clear cache if necessary
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light, // Force light mode for this screen
        primaryColor: ColorManager.lightPrimary, // Use your app's color
      ),
      child: Scaffold(
        backgroundColor: ColorManager.lightPrimary,
        body: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (isLoading) // Show loading indicator while WebView is loading
              Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                  backgroundColor: ColorManager.greyText,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
