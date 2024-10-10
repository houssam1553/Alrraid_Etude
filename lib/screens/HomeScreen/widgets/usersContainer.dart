import 'package:arraid/commun%20widgets/customInput.dart';
import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/controllers/usersController.dart';
import 'package:arraid/models/userListModel.dart';
import 'package:arraid/screens/HomeScreen/widgets/userCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UsersContainer extends StatefulWidget {
  const UsersContainer({
    super.key,
    required this.width,
    required this.height,
    required this.userController,
  });

  final UserController userController;
  final double width;
  final double height;

  @override
  _UsersContainerState createState() => _UsersContainerState();
}

class _UsersContainerState extends State<UsersContainer> {
  void _showAddUserDialog() {
    // Initialize a list to keep track of selected users
    List<bool> selectedUsers = widget.userController.users
        .map((user) =>
            user.isEmployee == 'true') // Assuming isEmployee is a String
        .toList();

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add team members',
            style: TextStyle(
              fontSize: 22,
              color: ColorManager.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children:
                  List.generate(widget.userController.users.length, (index) {
                return Obx(() {
                  var user = widget.userController.users[index];

                  // Temporary state to track checkbox selection
                  bool isChecked = user.isEmployee == 'true';

                  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${user.firstName} ${user.lastName}'),
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          // Check if user is trying to uncheck the box
                          if (value == false) {
                            // Show snackbar informing the user they cannot uncheck
                           Get.closeAllSnackbars();
                            Get.snackbar(
                              "Action Denied",
                              "You can remove team members from Team members page.",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.orange,
                            );
                          } else {
                            // If checking the box, update the user in the controller
                            widget.userController.updateUser(user.copyWith(
                                    isEmployee: 'true') // or handle as needed
                                );
                          }
                          // Keep the checkbox state as is
                          setState(() {
                            isChecked = value ==
                                true; // Do not update the value if unchecked
                          });
                        },
                      ),
                    ],
                  );
                });
              }),
            ),
          ),
          actions: [
            // Show loading indicator
            TextButton(
              child: Text('Save',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorManager.primary)),
              onPressed: () {
                widget.userController.isLoading1.value = true;
                // Collect users who became employees
                List<Userlistmodel> updatedUsers = widget.userController.users
                    .where((user) => user.isEmployee == 'true')
                    .toList();

                // Handle the logic to update users
                widget.userController.updateUsers(
                    updatedUsers); // Call update method with all changed users

                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: ColorManager.primary)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // Using Obx to reactively listen for loading state changes
        if (widget.userController.isLoading1.value) {
          return Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                  backgroundColor: ColorManager.greyText,
                ),
              ),
            ],
          );
        }

        return Container(
          width: widget.width * 0.7,
          padding: EdgeInsets.symmetric(
              horizontal: widget.width * 0.03, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child:   RefreshIndicator(
    onRefresh: () async {
      // Define the logic to refresh the data here
      await widget.userController.loadUsers(); // Fetch updated data from controller
    },
    child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Platform users",
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorManager.primary,
                    ),
                  ),
                  Obx((){
                    
           
                   return
                  IconButton(
                    
                    icon: Icon(
                      Iconsax.user_cirlce_add,
                      color: ColorManager.greyText,
                      size: 30,
                    ),
                    onPressed:
                    
                    widget.userController.isEmpty.value ? (){}: _showAddUserDialog,
                  );}
                  ),
                ],
              ),
    ListView.builder( scrollDirection: Axis.vertical,
        shrinkWrap: true,
                      itemCount: widget.userController.users.length,
                      itemBuilder: (context, index) {
          return Obx(() {
            var user = widget.userController.users[index];
            return UserCard(
              isTeamPage: false,
              index: index,
              isExpanded:
                  widget.userController.expandedCardIndex.value == index,
              onTap: widget.userController.toggleExpand,
              assetImage: user.imageUrl ?? '',
              title: '${user.firstName} ${user.lastName}',
              email: user.email,
              organization:
                  (user.platforms != null && user.platforms!.length > 1)
                      ? user.platforms![1]
                      : 'Alrraid Pro',
              subtitle:
                  (user.privileges != null && user.privileges!.isNotEmpty)
                      ? user.privileges![0]
                      : '   user',
              firstName: user.firstName,
              lastName: user.lastName,
            );
          });
        }),
      
  ],
      ),

          
          ),
        );
      },
    );
  }
}
