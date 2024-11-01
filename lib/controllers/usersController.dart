import 'package:arraid/commun%20widgets/customSnackbar.dart';
import 'package:arraid/controllers/sidebarController.dart';
import 'package:arraid/models/userListModel.dart';
import 'package:arraid/repositories/homeRepository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
 
  final Homerepository homeRepository;

  UserController(this.homeRepository);
  SidebarController sidebarController = Get.find<SidebarController>();

  var expandedCardIndex = Rxn<int>();  // Index of the expanded card
  var editingCardIndex = Rxn<int>();  // Index of the editing card
  final users = RxList<Userlistmodel>(); 
  var isLoading = true.obs; 
  var saveLoading = false.obs; 

  //var isLoading1 = false.obs; 
   var isEmpty = true.obs;
  var isFirstFetch = true.obs; 
   // List of user data
void closeSnackbars() {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
      print('Closed existing snackbars');
    }
  }
  // Method to load users from the repository
 Future<List<Userlistmodel>> loadUsers() async {
    isLoading.value = true; 
  try {

    List<Userlistmodel> fetchedUsers = await homeRepository.fetchUsers();
    users.clear(); // Clear the existing list
    users.addAll(fetchedUsers); 
  //  print(users[1].platforms );
    isFirstFetch.value = false;
      isEmpty.value = false;

         if (users.isEmpty && sidebarController.selectedIndex.value ==1 ){
     print("*****${sidebarController.selectedIndex.value}");


       Userlistmodel  defaultuser =Userlistmodel(id: "id", email: "example", firstName: "thameur", lastName: "alrraid");
  //  Get.snackbar("Empty List", "Could not retrieve any users members", snackPosition: SnackPosition.TOP); await Future.delayed(Duration(seconds: 2));
   await Future.delayed(Duration(seconds: 2));
    Customsnackbar.show(
  title:"Empty List",
  message: "Could not retrieve any users members",

);

  users.value = [defaultuser];
    }  
    // Add fetched users to the observable list
    return fetchedUsers;
  } catch (e) {
    print("Error loading users: $e");
    Get.snackbar("Server Error", "could not retreive users ",snackPosition: SnackPosition.TOP);
     isEmpty.value = true;
           isFirstFetch.value = false;
            
    return [];
        } finally {
      isLoading.value = false; 
  
        // Set loading to false when done
    }

    
  // Return an empty list in case of an error
  
}

Future<void> triggerRefresh() async {
    await loadUsers();
  }
 Future<void> deleteUser(String userId) async {
  try {
    // Find the index of the user to update
    

    
    // If user is found, update the user in the list
  await homeRepository.deleteUser(userId);

      // Call the repository method to update the user in the backend
       // Replace with your repository call
    Get.snackbar("Success", "user deleted", snackPosition: SnackPosition.TOP);
   
  } catch (e) {
    // Handle errors and provide feedback to the user
    Get.snackbar("Error", "Failed to update user. Please try again.", snackPosition: SnackPosition.TOP);
  }
}
Future<void> updateUserInfo(Userlistmodel updatedUser) async {
   saveLoading.value = true; 
  try {
    // Find the index of the user to update
    int index = users.indexWhere((user) => user.id == updatedUser.id);

    
    // If user is found, update the user in the list
   
      // Create a new user instance with updated isEmployee
     // team[index] = updatedUser.copyWith();

   await homeRepository.updateUser(updatedUser);
      // Call the repository method to update the user in the backend
       // Replace with your repository call


      // Handle case where user was not found
      
 
  } catch (e) {
    // Handle errors and provide feedback to the user
   
    Get.snackbar("Error", "Failed to update user. Please try again.", snackPosition: SnackPosition.TOP);
  }
    finally{
   saveLoading.value = false; 

  }
}



void updateUsers(List<Userlistmodel> updatedUsers) async {
  // Set loading state to true before starting the update
  isLoading.value = true;

  try {
    // Call the repository method to update users
    await homeRepository.updatedUsers(updatedUsers);
    
    Get.snackbar("Success", "Team members list updated successfully!", snackPosition: SnackPosition.BOTTOM);
  } catch (e) {
    // Handle errors and provide feedback to the user
    print("Error updating users: $e");
    Get.snackbar("Error", "Failed to update users. Please try again.", snackPosition: SnackPosition.BOTTOM);
  } finally {
    // Ensure loading state is reset
    isLoading.value = false;
  }
}

void updateUser(Userlistmodel updatedUser) async {
 

  try {
    // Find the index of the user to update
    int index = users.indexWhere((user) => user.id == updatedUser.id);
    print(index);
    
    // If user is found, update the user in the list
    if (index != -1) {
      // Create a new user instance with updated isEmployee
      users[index] = updatedUser.copyWith(isEmployee: "true");
      print(users[index].isEmployee);

      // Call the repository method to update the user in the backend
       // Replace with your repository call

    } else {
      // Handle case where user was not found
      Get.snackbar("Error", "User not found.", snackPosition: SnackPosition.TOP);
    }
  } catch (e) {
    // Handle errors and provide feedback to the user
    Get.snackbar("Error", "Failed to update user. Please try again.", snackPosition: SnackPosition.TOP);
  }

}





  @override
  void onInit() {
   
    //loadUsers(); // Load users when the controller is initialized
    super.onInit();
  }

  // Toggle card expansion
  void toggleExpand(int index) {
    expandedCardIndex.value = (expandedCardIndex.value == index) ? null : index;

    // Reset edit state when expanding a new card
    if (editingCardIndex.value != null && editingCardIndex.value != index) {
      editingCardIndex.value = null;
    }
  }

  // Toggle edit mode
  void toggleEdit(int index) {
    if (editingCardIndex.value == index) {
      editingCardIndex.value = null;  // Exit edit mode if clicked again
    } else {
      editingCardIndex.value = index;  // Enter edit mode
      expandedCardIndex.value = null;  // Collapse the card when editing starts
    }
  }

  // Update the organization field for a specific user
/*   void updateOrganization(int index, String newOrganization) {
    if (index >= 0 && index < users.length) {
      final updatedUser = users[index].copyWith(platforms: [newOrganization]);
      users[index] = updatedUser;
    }
  } */
}
