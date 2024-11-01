import 'package:arraid/config/bindings/appBindings.dart';
import 'package:arraid/config/theme.dart';
import 'package:arraid/screens/HomeScreen/homeScreen.dart';
import 'package:arraid/screens/LoginScreen/loginScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
 
 if (kReleaseMode) { 
   await SentryFlutter.init(
    (options) {
      options.dsn = 'https://5cee72f343430973a64682d7fc936206@o4508149717336064.ingest.de.sentry.io/4508149725855824';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MainApp()),
  );
  }else {
     runApp(const MainApp());
  }

  // or define SENTRY_DSN via Dart environment variable (--dart-define)
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
    return  GetMaterialApp(
       initialBinding: AppBindings(), 
    

      theme: AppTheme.lighttheme,
      darkTheme: AppTheme.darktheme,

      themeMode: ThemeMode.light,
      home: Homescreen()
    );
  }
}
