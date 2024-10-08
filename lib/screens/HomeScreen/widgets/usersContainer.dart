import 'package:arraid/commun%20widgets/customInput.dart';
import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
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
      children: List.generate(widget.userController.users.length, (index) {
        return Obx(() {
          var user = widget.userController.users[index];

          // Temporary state to track checkbox selection
          bool isChecked = user.isEmployee == 'true';

          return Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  // Temporarily update the selection in memory, but not in the controller
                  setState(() {
                        //user.isEmployee = value == true ? 'true' : 'false'; // Update in local user object
                          widget.userController.updateUser(user); 
                       

                  });
                },
              ),
              Text('${user.firstName} ${user.lastName}'),
            ],
          );
        });
      }),
    ),
  ),
  actions: [
    TextButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    TextButton(
      child: Text('Save'),
      onPressed: () {
        // Collect users who became employees
        List<Userlistmodel> updatedUsers = widget.userController.users.where((user) => user.isEmployee == 'true').toList();

        // Handle the logic to update users
        widget.userController.updateUsers(updatedUsers); // Call update method with all changed users

        Navigator.of(context).pop(); // Close the dialog
      },
    ),
  ],
);

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.7,
      padding:
          EdgeInsets.symmetric(horizontal: widget.width * 0.03, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
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
              IconButton(
                icon: Icon(
                  Iconsax.user_cirlce_add,
                  color: ColorManager.greyText,
                  size: 30,
                ),
                onPressed: _showAddUserDialog,
              ),
            ],
          ),
          SizedBox(height: 10),
          ...List.generate(widget.userController.users.length, (index) {
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
    );
  }
}
