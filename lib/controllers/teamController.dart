import 'package:arraid/commun%20widgets/customSnackbar.dart';
import 'package:arraid/controllers/sidebarController.dart';
import 'package:arraid/models/userListModel.dart';
import 'package:arraid/repositories/homeRepository.dart';
import 'package:get/get.dart';

class TeamController extends GetxController {
 
  final Homerepository homeRepository;

  TeamController(this.homeRepository);
 SidebarController sidebarController = Get.find<SidebarController>();
  var expandedCardIndex = Rxn<int>();  // Index of the expanded card
  var editingCardIndex = Rxn<int>();  // Index of the editing card
  final team = RxList<Userlistmodel>(); 
  var isLoading = true.obs; 
  var deleteLoading = false.obs; 
  var saveLoading = false.obs; 


  

  var isFirstFetch = true.obs; 


   // List of user data
   

  // Method to load users from the repository
 Future<List<Userlistmodel>> loadTeamMembers() async {
  isLoading.value = true; 
  try {
    // Fetch all users
    List<Userlistmodel> fetchedUsers = await homeRepository.fetchUsers();
    
    // Filter users where isEmployee is true
    List<Userlistmodel> teamMembers = fetchedUsers.where((user) => user.isEmployee == "true").toList();

    team.clear(); // Clear the existing list
    team.addAll(teamMembers); // Add filtered team members to the observable list
   
  
    isFirstFetch.value = false;
    expandedCardIndex.value = -1;
     await Future.delayed(Duration(seconds: 2));
         if (team.isEmpty && sidebarController.selectedIndex.value ==2 ){
     


       Userlistmodel  defaultuser =Userlistmodel(id: "id", email: "example", firstName: "thameur", lastName: "alrraid");
  //  Get.snackbar("Empty List", "Could not retrieve any team members", snackPosition: SnackPosition.TOP);
    Customsnackbar.show(
  title:"Empty List",
  message: "Could not retrieve any team members",

);

  team.value = [defaultuser];
    }  
    
    return teamMembers;
  } catch (e) {
if (team == [] ){
    Get.snackbar("Server Error", "Could not retrieve team members", snackPosition: SnackPosition.TOP);
    
    };
  Userlistmodel  defaultuser =Userlistmodel(id: "id", email: "example", firstName: "thameur", lastName: "alrraid");
    
        isFirstFetch.value = false;
         await Future.delayed(Duration(seconds: 2));
          return [defaultuser];
  
  } finally {
    isLoading.value = false; // Set loading to false when done
  }



}Future<void> triggerRefresh() async {
    await loadTeamMembers();
  }
 Future<void> deleteUser(String userId) async {
   deleteLoading.value = true; 
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
   finally{
    deleteLoading.value = false;
  } 
}
Future<void> updateUserInfo(Userlistmodel updatedUser) async {
   saveLoading.value = true; 
  
  try {
    // Find the index of the user to update
    int index = team.indexWhere((user) => user.id == updatedUser.id);

    
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
  }finally{
   saveLoading.value = false; 
    
  }
}


  @override
  void onInit() {
    //loadTeamMembers(); // Load users when the controller is initialized
    super.onInit();
  }

  // Toggle card expansion
  void toggleExpand(int index1) {
    expandedCardIndex.value = (expandedCardIndex.value == index1) ? null : index1;

    // Reset edit state when expanding a new card
    if (editingCardIndex.value != null && editingCardIndex.value != index1) {
      editingCardIndex.value = null;
    }
  }

  // Toggle edit mode
  void toggleEdit(int index1) {
    if (editingCardIndex.value == index1) {
      editingCardIndex.value = null;  // Exit edit mode if clicked again
    } else {
      editingCardIndex.value = index1;  // Enter edit mode
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
