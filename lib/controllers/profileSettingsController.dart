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
  var imagechanged  = false.obs; 
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
       await loadImage();
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
firstNameController.text =updatedUser.firstName ;

lastNameController.text =updatedUser.lastName ;

      // Call the repository method to update the user info (assumes you have an updateUser method in your repository)
      await homeRepository.updateUser(updatedUser);
await LocalService.saveUser(updatedUserData);
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
 
 Future<void> loadImage() async {
  if (currentUser.value == null) {print("Null image ");};

  final email = currentUser.value!.email;
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String filePath = '${appDocDir.path}/profilePic_$email.png';
  final File savedImage = File(filePath);

  if (await savedImage.exists()) {
    profileImage.value = savedImage; // Load profile image for the specific user
  } else {
    profileImage.value = null; // No saved image for this user
  }
}


 Future<void> editButtonClicked(String email) async {
  try {
    // Use the email to fetch user-specific data (e.g., user profile picture).
    print('Loading data for email: $email');
    
    // Fetch user-specific profile picture based on email (this is just an example)
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String filePath = '${appDocDir.path}/profilePic_$email.png';  // Custom path based on email
    final File savedImage = File(filePath);

    if (await savedImage.exists()) {
      print('Image file exists, showing dialog');
      showImageOptionsDialog();
    } else {
      print('No existing image found for email $email. Opening gallery...');
      imagechanged.value = false;

       // Show success animation

      try {
        await pickImage(ImageSource.gallery); // Attempt to pick image
        print('Image picked successfully.');
        imagechanged.value = true; // Update only if an image was successfully picked
      } catch (e) {
        print('Error picking image: $e');
        imagechanged.value = false; // Ensure no change if there's an error
      }

      print('Image change status after picking: ${imagechanged.value}');
    }
  } catch (e) {
    print('Error in editButtonClicked: $e');
  }
}



  void showImageOptionsDialog() {
    imagechanged.value = true;
  
    Get.dialog(
      AlertDialog(
        title: Center(child: const Text('Profile Picture Options', style: TextStyle(color: ColorManager.primary, fontWeight: FontWeight.bold))),
        content: Text('You already have a profile picture. What would you like to do?', style: TextStyle(color: ColorManager.greyText)),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              pickImage(ImageSource.gallery); // Choose a new image
            },
            child: const Text('Change'),
          ),
          TextButton(
            onPressed: () async {
              await deleteProfileImage();
              //Get.back(); // Close the dialog after deletion
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

  }
Future<void> deleteProfileImage() async {
  if (currentUser.value == null) return;

  final email = currentUser.value!.email;
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String filePath = '${appDocDir.path}/profilePic_$email.png';
  final File savedImage = File(filePath);
  imagechanged.value= false;
 profileImage.value = null;
  if (await savedImage.exists()) {
    await savedImage.delete();
   
  }
  Get.back(); // Close dialog after deletion
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

 void showSaveImageDialog(File imageFile) {
  print('Showing save dialog for the image...');
  Get.dialog(
    AlertDialog(
      title: Center(
        child: const Text(
          'Save Image',
          style: TextStyle(
              color: ColorManager.primary, fontWeight: FontWeight.bold),
        ),
      ),
      content: Text(
        'Do you want to save this image as your profile picture?',
        style: TextStyle(color: ColorManager.greyText),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            print('Cancel button pressed');
            print(imagechanged.value);

            if (imagechanged.value) {
              imagechanged.value = false;
              await revertToPreviousImage(currentUser.value!.email);
               
            } else {
              await deleteProfileImage();
            }

            // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            print('Save button pressed');
            print(imageFile.path);

            await saveImage(imageFile); // Save image
            Get.back(); // Close the dialog after saving
          },
          child: const Text(
            'Save',
            style: TextStyle(color: ColorManager.primary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

Future<void> revertToPreviousImage(String email) async {
  try {
    // Construct the file path based on the email to fetch the user's profile picture
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String filePath = '${appDocDir.path}/profilePic_$email.png';  // Use email to generate a unique file path
    final File savedImage = File(filePath);

    // Close the current screen/dialog before proceeding
    Get.back();

    // Check if the profile image exists for this user
    if (await savedImage.exists()) {
      print('Reverting to previous image for email: $email');
      profileImage.value = savedImage;  // Set the profile image to the saved one
    } else {
      print('No previous image found for email $email.');
       imagechanged.value= false;
 profileImage.value = null;

    }
  } catch (e) {
    print('Error in revertToPreviousImage: $e');
  }
}

Future<void> saveImage(File imageFile) async {
  if (currentUser.value == null) return;

  final email = currentUser.value!.email;
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String filePath = '${appDocDir.path}/profilePic_$email.png';

  try {
    await imageFile.copy(filePath); // Save the cropped image with the email-based filename
    profileImage.value = File(filePath); // Update the profileImage observable
  } catch (e) {
    print('Error saving image: $e');
  }
}


}
