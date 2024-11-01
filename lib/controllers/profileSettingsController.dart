import 'package:arraid/models/userModel.dart';
import 'package:arraid/services/localService.dart';
import 'package:get/get.dart';

class ProfileSettingsController extends GetxController {
  Rx<User?> currentUser = Rx<User?>(null); // Create an observable User object

  @override
  void onInit() {
    fetchCurrentUser(); // Fetch the current user when the controller is initialized
    super.onInit();
  }
 
  Future<void> fetchCurrentUser() async {
    try {
      final fetchedUser = await LocalService.getUser();
      if (fetchedUser != null) {
        currentUser.value = fetchedUser; // Update the observable user if fetchedUser is not null
      } else {
        // Fill with default values when no user is found
        currentUser.value = User(
          firstName: "First Name", // Default first name
          lastName: "Last Name",   // Default last name
          email: "example@email.com", // Default email
          isEmployee: "false",
           id: '',    
           type: '',   // Default isEmployee status
        );
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
