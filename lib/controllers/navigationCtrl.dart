import 'package:arraid/screens/cmng.dart';
import 'package:arraid/screens/loginScreen.dart';
import 'package:arraid/screens/tabs/loginTab.dart';

import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final tabs = [
    ComingSoon(),
  
   Logintab(),
    
    
  ];
}