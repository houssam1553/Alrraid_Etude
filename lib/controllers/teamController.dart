import 'package:arraid/models/userListModel.dart';
import 'package:arraid/repositories/homeRepository.dart';
import 'package:get/get.dart';

class TeamController extends GetxController {
 
  final Homerepository homeRepository;

  TeamController(this.homeRepository);

  var expandedCardIndex = Rxn<int>();  // Index of the expanded card
  var editingCardIndex = Rxn<int>();  // Index of the editing card
  final team = RxList<Userlistmodel>(); 
  var isLoading = true.obs; 
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
    
    
    
    return teamMembers;
  } catch (e) {
    print("Error loading team members: $e");
    Get.snackbar("Server Error", "Could not retrieve team members", snackPosition: SnackPosition.TOP);
    return [];
  } finally {
    isLoading.value = false; // Set loading to false when done
  }
}
void deleteUser(String userId) async {
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
