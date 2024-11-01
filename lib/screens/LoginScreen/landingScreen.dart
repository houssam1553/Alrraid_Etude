import 'package:arraid/config/colors.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class landingScreen extends StatefulWidget {
  @override
  State<landingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<landingScreen> {
  late WebViewController _controller;
  bool _isLoading = true; // Flag to show the loading indicator

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true; // Show loader when the page starts loading
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false; // Hide loader when the page finishes loading
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://alrraid.com/en'));
  }

  @override
  void dispose() {
    // Optional: Clear cache if necessary
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
        body: CustomMaterialIndicator(
          onRefresh: () async {
            // Call the refresh logic to load team members
    await Future.delayed(Duration(seconds: 2)); // Show success animation
            
           
          },
          backgroundColor: Colors.white,
          indicatorBuilder: (context, controller) {
            return controller.value < 0.5
                ? Icon(
                    Icons.refresh, // Circular refresh arrow icon
                    color: ColorManager.primary, // Replace with your desired color
                    size: 30, // Adjust size if needed
                  )
                : Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CircularProgressIndicator(
                    color: ColorManager.primary,
              backgroundColor: ColorManager.greyText,
                    ),
                  );
          },
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (_isLoading) // Show loading indicator while WebView is loading
                Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                    backgroundColor: ColorManager.greyText,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
