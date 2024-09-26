
import 'package:get/get.dart';

class UserController extends GetxController {
  var expandedCardIndex = Rxn<int>();  // Index of the expanded card
  var editingCardIndex = Rxn<int>(); 
 final users = [
    {
      "name": "John Doe",
      "email": "example@gmail.com",
      "organization": "Organization A",
      "subtitle": "Software Engineer",
      "image": "assets/images/user1.png"
    }.obs,  // Make this RxMap
    {
      "name": "Jane Smith",
      "email": "example@gmail.com",
      "organization": "Organization B",
      "subtitle": "Product Manager",
      "image": "assets/images/user2.png"
    }.obs,  // Make this RxMap
    {
      "name": "Sam Wilson",
      "email": "example@gmail.com",
      "organization": "Organization C",
      "subtitle": "UI/UX Designer",
      "image": "assets/images/user3.png"
    }.obs,  // Make this RxMap
  ].obs;  // Index of the editing card

  void toggleExpand(int index) {
    // If the clicked card is already expanded, collapse it; otherwise, expand the new card
    expandedCardIndex.value = (expandedCardIndex.value == index) ? null : index;

    // When expanding a new card, reset the edit state
    if (editingCardIndex.value != null && editingCardIndex.value != index) {
      editingCardIndex.value = null;
    }
  }

  void toggleEdit(int index) {
    // Toggle the edit mode for the clicked card
    if (editingCardIndex.value == index) {
      editingCardIndex.value = null;  // Exit edit mode if clicked again
    } else {
      editingCardIndex.value = index;  // Enter edit mode
      expandedCardIndex.value = null;  // Collapse the card when editing starts
    }
  }
    void updateOrganization(int index, String newOrganization) {
    users[index]["organization"] = newOrganization;
  }

}