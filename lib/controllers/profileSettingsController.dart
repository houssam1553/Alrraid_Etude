import 'dart:io';

import 'package:arraid/config/colors.dart';
import 'package:arraid/models/userListModel.dart'; // Assuming Userlistmodel and User are different
import 'package:arraid/models/userModel.dart'; // Your User model
import 'package:arraid/repositories/homeRepository.dart';
import 'package:arraid/screens/LoginScreen/loginScreen.dart';
import 'package:arraid/services/localService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileSettingsController extends GetxController {
  Rx<User?> currentUser = Rx<User?>(null); // Observable for current user
  final Homerepository homeRepository;
 

  final TextEditingController currentPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
 RxString fNameHint = ''.obs;
 RxString lNameHint = ''.obs;



  var saveLoading = false.obs; 
  var changePassLoading = false.obs; 

  // To track loading state during save operation
  var logoutLoading = false.obs; // To track loading state during save operation
  var obscurePassword = true.obs; // RxBool for password visibility
  
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value; // Toggle password visibility
  }
  ProfileSettingsController(this.homeRepository);
   final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    fetchCurrentUser();
   // loadProfileImage(); // Load profile image when the controller is initialized
     // Fetch the current user when the controller is initialized
    super.onInit();
  }

  // Fetch current user from local storage
  Future<void> fetchCurrentUser() async {
    try {
      final fetchedUser = await LocalService.getUser();
     // print(fetchedUser!.id);

      if (fetchedUser != null) {
        // Update the observable currentUser if fetchedUser is not null
        currentUser.value = fetchedUser;
      } else {
        // If no user is found, set to default values
        currentUser.value = User(
          firstName: "First Name", // Default first name
          lastName: "Last Name",   // Default last name
          email: "example@email.com", // Default email
          isEmployee: "false",      // Default isEmployee status
          id: '',    
          clerkId: '',               // Default id
          type: '',                 // Default type
        );
      }
    } catch (e) {
    //  print('Error fetching user data: $e');
    }
  }

  // Method to update user info
  Future<void> updateUserInfo(Userlistmodel updatedUser) async {
    saveLoading.value = true; // Set loading to true while the update is in progress
    try {
      // Here you can convert Userlistmodel to User if needed before updating
      User updatedUserData = User(
        firstName: updatedUser.firstName ?? currentUser.value?.firstName ?? "First Name",
        lastName: updatedUser.lastName ?? currentUser.value?.lastName ?? "Last Name",
        email: updatedUser.email ?? currentUser.value?.email ?? "example@email.com",
        isEmployee: updatedUser.isEmployee ?? currentUser.value?.isEmployee ?? "false",
        id: updatedUser.id,
        clerkId: updatedUser.id,
        type: updatedUser.type ?? currentUser.value?.type ?? "",
      );
fNameHint.value = updatedUser.firstName;
lNameHint.value = updatedUser.lastName;

      // Call the repository method to update the user info (assumes you have an updateUser method in your repository)
      await homeRepository.updateUser(updatedUser);

      // After successfully updating, fetch the updated user
      await fetchCurrentUser();  // This will fetch the user again and update the observable state

      // Optional: You can update the local storage or perform other operations here

    } catch (e) {
      // Show error message if the update fails
      Get.snackbar("Error", "Failed to update user. Please try again.", snackPosition: SnackPosition.TOP);
    } finally {
      saveLoading.value = false; // Set loading to false once the operation is complete
    }
  }
    Future<void> updateUserPassword(  {
  required String? userId,
  required String currentPassword,
  required String newPassword,
}) async {
    changePassLoading.value = true; // Set loading to true while the update is in progress
    try {
      // Here you can convert Userlistmodel to User if needed before updating
    

      // Call the repository method to update the user info (assumes you have an updateUser method in your repository)
      await homeRepository.changePassword(userId:userId,currentPassword:currentPassword ,newPassword:newPassword );


      // After successfully updating, fetch the updated user
      await fetchCurrentUser();  // This will fetch the user again and update the observable state
passwordController.clear();
currentPasswordController.clear();
confirmPasswordController.clear();

      // Optional: You can update the local storage or perform other operations here

    } catch (e) {
      // Show error message if the update fails
      Get.snackbar("Error", "Failed to update user. Please try again.", snackPosition: SnackPosition.TOP);
    } finally {
      changePassLoading.value = false; // Set loading to false once the operation is complete
    }
  }

   Future<void> logout() async {
    logoutLoading.value = true; // Set loading to true while the update is in progress

    try {
      // Clear the user's data from local storage
      await LocalService.clearUser();  // Assuming clearUser() method removes user data from local storage

      // Set currentUser to null
      currentUser.value = null;
    // await Future.delayed(Duration(seconds: 1));

      // Optionally, you can navigate the user to the login screen after logout
      Get.offAll(LoginScreen()); // Navigate to the login screen

    } catch (e) {
      // Show an error message if logout fails
      Get.snackbar("Error", "Logout failed. Please try again.", snackPosition: SnackPosition.TOP);
    }finally{
    logoutLoading.value = false; // Set loading to true while the update is in progress

    }
  }
  
 Rx<File?> profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  // Pick an image from the specified source (gallery/camera)
  // Future<void> pickImage(ImageSource source) async {
  //   try {final status = await Permission.storage.request();
  // print('Permission status: $status');
  //     print('Picking image from source: $source');
  //     final XFile? pickedFile = await _picker.pickImage(source: source);
  //     if (pickedFile != null) {
  //       final File imageFile = File(pickedFile.path);
  //       profileImage.value = imageFile;

  //       print('Image picked: ${imageFile.path}');

  //       // Show the confirmation dialog
  //       showSaveImageDialog(imageFile);
  //     } else {
  //       print('No image picked.');
  //     }
  //   } catch (e) {
  //     print('Error picking image: $e');
  //   }
  // }

  // Show a confirmation dialog to save the image
  void showSaveImageDialog(File imageFile) {
    print('Showing save dialog for the image...');
    Get.dialog(
      AlertDialog(
        title: Center(child: const Text('Save Image',style: TextStyle(color: ColorManager.primary,fontWeight: FontWeight.bold))),
        content:  Text('Do you want to save this image as your profile picture?',style: TextStyle(color: ColorManager.greyText)),
        actions: [
          TextButton(
            onPressed: () {
              print('Cancel button pressed');
              Get.back(); // Close the dialog without saving
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              print('Save button pressed');
              await saveImage(imageFile);
              Get.back(); // Close the dialog after saving
            },
            child: const Text('Save',style: TextStyle(color: ColorManager.primary,fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Save the image to local storage
  Future<void> saveImage(File imageFile) async {
    try {
      print('Starting to save the image...');
      
      // Get the directory to save the image (App document directory)
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String filePath = '${appDocDir.path}/profilePic.png';

      print('Directory path for saving: $filePath');

      // Check if the file already exists at the location
      final bool exists = await File(filePath).exists();
      if (exists) {
        print('File already exists at $filePath');
      } else {
        print('No file found at the path, proceeding with copy');
      }

      // Copy the selected image to the local app directory
      final File savedImage = await imageFile.copy(filePath);
      print('Image saved successfully to $filePath');

      // Update profile image observable with the saved file
     // profileImage.value = savedImage;

      // Optional: Show a success message
     Get.back();
    } catch (e) {
      print('Error saving the image: $e');
      Get.snackbar('Error', 'Failed to save the image: $e');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final status = await Permission.storage.request();
      print('Permission status: $status');

      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        // Crop the image
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          
          sourcePath: imageFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1), // Square for circular display
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Edit Image',
              toolbarColor: ColorManager.primary,
              toolbarWidgetColor: Colors.white,
              hideBottomControls: true,
              cropStyle: CropStyle.circle,
              lockAspectRatio: true, // Locks to square crop
            ),
            IOSUiSettings(
              title: 'Edit Image',
              aspectRatioLockEnabled: true, // Locks aspect ratio for circular display
            ),
          ],
        );

        if (croppedFile != null) {
          // Convert CroppedFile to File and update profile image
          profileImage.value = File(croppedFile.path);
          showSaveImageDialog(profileImage.value!); // Show confirmation dialog to save
        }
      } else {
        print('No image picked.');
      }
    } catch (e) {
      print('Error picking or cropping image: $e');
    }
  }
   Future<void> loadImage() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String filePath = '${appDocDir.path}/profilePic.png';

    final File savedImage = File(filePath);
    if (await savedImage.exists()) {
      profileImage.value = savedImage; // Update profile image
    }
  }
}
