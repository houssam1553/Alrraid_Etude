import 'package:arraid/config/theme.dart';
import 'package:arraid/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [
            SystemUiOverlay.top, // Shows Status bar and hides Navigation bar
          ],
        );
    return  MaterialApp(
      theme: AppTheme.lighttheme,
      darkTheme: AppTheme.darktheme,
      themeMode: ThemeMode.light,
      home: LoginScreeen()
    );
  }
}