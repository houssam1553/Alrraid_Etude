import 'package:arraid/models/userListModel.dart';
import 'package:arraid/repositories/homeRepository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
 
  final Homerepository homeRepository;

  UserController(this.homeRepository);

  var expandedCardIndex = Rxn<int>();  // Index of the expanded card
  var editingCardIndex = Rxn<int>();  // Index of the editing card
  final users = RxList<Userlistmodel>(); 
  var isLoading = true.obs; 
   // List of user data

  // Method to load users from the repository
 Future<List<Userlistmodel>> loadUsers() async {
    isLoading.value = true; 
  try {

    List<Userlistmodel> fetchedUsers = await homeRepository.fetchUsers();
    users.clear(); // Clear the existing list
    users.addAll(fetchedUsers); 
    print(users[1].platforms );
    // Add fetched users to the observable list
    return fetchedUsers;
  } catch (e) {
    print("Error loading users: $e");
    Get.snackbar("Server Error", "could not retreive users ",snackPosition: SnackPosition.TOP);
    return [];
        } finally {
      isLoading.value = false; // Set loading to false when done
    }
  // Return an empty list in case of an error
  
}
  @override
  void onInit() {
    loadUsers(); // Load users when the controller is initialized
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
