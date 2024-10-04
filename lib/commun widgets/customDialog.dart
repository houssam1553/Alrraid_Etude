import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialogController extends GetxController {
  // Holds the loading state and the current icon state
  var isLoading = true.obs;
  var currentIcon = Rx<IconData>(Icons.hourglass_top); // Start with the hourglass icon

  // Holds the text message for loading, success, or error
  var message = 'Please wait'.obs;

  // Method to update the icon and message for success or error
  void updateStatus(bool isSuccess) {
    isLoading.value = false;  // Stop the loading indicator
    if (isSuccess) {
      currentIcon.value = Icons.check_circle; // Success icon
      message.value = 'Success!'; // Update the message to success
    } else {
      currentIcon.value = Icons.error;  // Error icon
      message.value = 'An error occurred'; // Update the message to error
    }
  }
   void resetState() {
    isLoading.value = true;  // Reset to loading state
    currentIcon.value = Icons.hourglass_top;  // Reset to hourglass icon
    message.value = 'Please wait';  // Reset the message
  }
}

class LoadingDialog {
  static final LoadingDialogController controller = Get.put(LoadingDialogController());

  // Show the dialog with a CircularProgressIndicator and transition to icons
  static void showLoadingDialog() {
       controller.resetState(); 
    Get.dialog(
      Center(
        child: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return   AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: controller.isLoading.value
                      ? SizedBox(
                          key: ValueKey('loading'),  // Unique key for CircularProgressIndicator
                          height: 90,  // Fixed height
                          width: 90,   // Fixed width
                          child: CircularProgressIndicator(
                            color: ColorManager.primary,
                            backgroundColor: ColorManager.lightGrey,
                            strokeWidth: 12.0,  // Adjust stroke width as needed
                          )
                        )
                      : SizedBox(
                          key: ValueKey(controller.currentIcon.value),  // Unique key for icons
                          // Fixed width for the icon
                          child: Icon(
                            controller.currentIcon.value,
                            size: 110,  // Ensure icon size matches CircularProgressIndicator
                            color: controller.currentIcon.value == Icons.check_circle
                                ? Colors.green  // Success icon color
                                : Colors.red,   // Error icon color
                          ),
                        ),
                );
              
              }),
              const SizedBox(height: 42),
              Obx(() {
                return 
                
DefaultTextStyle(
  style: TextStyle( fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.TextColor,),
  child: Text( controller.message.value, ),
)

            ;
              }),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Update the dialog to show the result (success or error)
  static void showResultIcon(bool isSuccess) {
    controller.updateStatus(isSuccess);
  }

  // Close any open dialog
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) {
     
      Get.back();
    }
  }
}
