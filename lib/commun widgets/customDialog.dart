import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialogController extends GetxController {
  var isLoading = true.obs;
  var currentIcon = Rx<IconData>(Icons.hourglass_top); // Start with the hourglass icon
  var message = 'Please wait'.obs;

  // Update the icon and message for success or error
  void updateStatus(bool isSuccess, {String? errorMessage}) {
    isLoading.value = false;  // Stop the loading indicator
    if (isSuccess) {
      currentIcon.value = Icons.check_circle;  // Success icon
      message.value = 'Success!';  // Update the message to success
    } else {
      currentIcon.value = Icons.error;  // Error icon
      message.value = errorMessage ?? 'An error occurred';  // Use custom error message if provided
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
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Stack(
            children: [
              // Positioned icon or loading indicator
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Obx(() {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: controller.isLoading.value
                        ? SizedBox(
                            key: ValueKey('loading'),
                            height: 90,
                            width: 90,
                            child: CircularProgressIndicator(
                              color: ColorManager.primary,
                              backgroundColor: ColorManager.lightGrey,
                              strokeWidth: 12.0,
                            ),
                          )
                        : SizedBox(
                            key: ValueKey(controller.currentIcon.value),
                            child: Icon(
                              controller.currentIcon.value,
                              size: 110,
                              color: controller.currentIcon.value == Icons.check_circle
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                  );
                }),
              ),
              
              // Positioned text message at the bottom center
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Obx(() {
                  return DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.TextColor,
                    ),
                    child: Text(
                      controller.message.value,
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  static void showResultIcon(bool isSuccess, {String? errorMessage}) {
    if (!isSuccess && errorMessage != null) {
      controller.message.value = errorMessage;
    }
    controller.updateStatus(isSuccess,errorMessage: errorMessage);
  }

  static void closeDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}

