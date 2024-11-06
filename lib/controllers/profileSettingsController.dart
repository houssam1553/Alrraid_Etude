import 'package:arraid/models/userListModel.dart'; // Assuming Userlistmodel and User are different
import 'package:arraid/models/userModel.dart'; // Your User model
import 'package:arraid/repositories/homeRepository.dart';
import 'package:arraid/screens/LoginScreen/loginScreen.dart';
import 'package:arraid/services/localService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettingsController extends GetxController {
  Rx<User?> currentUser = Rx<User?>(null); // Observable for current user
  final Homerepository homeRepository;
 
 

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
    fetchCurrentUser(); // Fetch the current user when the controller is initialized
    super.onInit();
  }

  // Fetch current user from local storage
  Future<void> fetchCurrentUser() async {
    try {
      final fetchedUser = await LocalService.getUser();
      print(fetchedUser!.id);

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
      print('Error fetching user data: $e');
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

      // Optionally, you can navigate the user to the login screen after logout
      Get.offAll(LoginScreen()); // Navigate to the login screen

    } catch (e) {
      // Show an error message if logout fails
      Get.snackbar("Error", "Logout failed. Please try again.", snackPosition: SnackPosition.TOP);
    }finally{
    logoutLoading.value = false; // Set loading to true while the update is in progress

    }
  }
}
