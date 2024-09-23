import 'package:arraid/config/colors.dart';

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lighttheme = ThemeData(
    fontFamily: 'Roboto',
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ColorManager.primary,
      onPrimary: Colors.white,
      secondary: ColorManager.secondary,
      onSecondary: Colors.white,
      primaryContainer: Colors.grey,
      error: Colors.red,
      onError: Colors.white,
      background: Color.fromARGB(255, 245, 245, 245),
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    textTheme: Htexttheme.lightText,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: Color.fromARGB(255, 201, 186, 225),
    ),
    cardTheme: const CardTheme(
      color: Color.fromARGB(255, 201, 186, 225),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(ColorManager.primary),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all(Htexttheme.lightButtonText.titleMedium),
      ),
    ),
    inputDecorationTheme: Hinputtheme.lightInput,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: ColorManager.primary),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(ColorManager.primary),
      ),
    ),
  );

  static ThemeData darktheme = ThemeData(
    fontFamily: 'Roboto',
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      shadow: Colors.white,
      primary: ColorManager.primary,
      onPrimary: Colors.white,
      secondary: ColorManager.secondary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Color.fromARGB(255, 19, 23, 25),
      onBackground: Colors.white,
      surface: Color.fromARGB(255, 30, 34, 39),
      onSurface: Colors.white,
    ),
    textTheme: Htexttheme.darkText,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        textStyle: MaterialStateProperty.all(Htexttheme.darkButtonText.titleMedium),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: Color.fromARGB(255, 201, 186, 225),
    ),
    cardTheme: const CardTheme(
      color: Color.fromARGB(255, 101, 81, 193),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: Colors.white),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),


     
    
  
  );
}
class Hinputtheme{
   static  InputDecorationTheme lightInput = InputDecorationTheme(
    
    
      labelStyle: TextStyle(
        color: ColorManager.greyText,  // Set the color of the label (when not focused)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: ColorManager.primary, // Border color when focused
        ),
      ),
       enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        
         borderSide: BorderSide( color: const Color.fromARGB(255, 208, 214, 222), // Border color
            width: 1.2,)
      ),
     
      hintStyle: TextStyle(
        color: ColorManager.greyText,  // Set the color of the label (when not focused)
      ),
      suffixIconColor: ColorManager.primary, // Icon color for password toggle or similar icons
    );
    
}

class Htexttheme {
  static const TextTheme lightText = TextTheme(
    displayLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.black),
    displaySmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: ColorManager.primary),
    headlineLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: ColorManager.primary),
    headlineMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.black),
    headlineSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, color: Colors.black),
    titleLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: ColorManager.TextColor),
    titleMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, color: Colors.black),
    titleSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, color: Colors.black),
    bodyLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.black),
    bodyMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: ColorManager.greyText),
    bodySmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.black),
    labelLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, color: ColorManager.TextColor),
    labelMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: ColorManager.greyText),
    labelSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.black),
  );

  static const TextTheme darkText = TextTheme(
    displayLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
    headlineLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
    headlineSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, color: Colors.white),
    titleLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, color: Colors.white),
    titleMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, color: Colors.white),
    titleSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, color: Colors.white),
    bodyLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.white),
    bodyMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.white),
    bodySmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.white),
    labelLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.white),
    labelSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.white),
  );

  static const TextTheme lightButtonText = TextTheme(
    titleMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.black),
  );

  static const TextTheme darkButtonText = TextTheme(
    titleMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
  );
}




