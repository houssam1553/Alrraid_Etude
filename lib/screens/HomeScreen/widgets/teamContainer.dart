import 'package:arraid/commun%20widgets/customInput.dart';
import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/teamController.dart';
import 'package:arraid/controllers/usersController.dart';
import 'package:arraid/models/userListModel.dart';
import 'package:arraid/screens/HomeScreen/widgets/teamCard.dart';
import 'package:arraid/screens/HomeScreen/widgets/userCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TeamContainer extends StatefulWidget {
  const TeamContainer({
    super.key,
    required this.width,
    required this.height,
    required this.teamController,
  });

  final TeamController teamController;
  final double width;
  final double height;

  @override
  _TeamContainerState createState() => _TeamContainerState();
}

class _TeamContainerState extends State<TeamContainer> {
  /* void _showAddUserDialog() {
    // Initialize a list to keep track of selected team
    List<bool> selectedUsers = widget.teamController.team
        .map((user) =>
            user.isEmployee == 'true') // Assuming isEmployee is a String
        .toList();

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Team Members',
            style: TextStyle(
              fontSize: 22,
              color: ColorManager.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children:
                  List.generate(widget.teamController.team.length, (index) {
                return Obx(() {
                  var user = widget.teamController.team[index];
                  return Row(
                    children: [
                      Checkbox(
                        value: user.isEmployee == 'true',
                        onChanged: (bool? value) {
                          // Update the isEmployee state
                          //  user.isEmployee = value == true ? 'true' : 'false';
                          // Trigger an update
                          //  widget.teamController.updateUser(user);
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
                // Handle the logic to add selected team as team members
                List<Userlistmodel> teamMembers = [];
                for (int i = 0; i < selectedUsers.length; i++) {
                  if (selectedUsers[i]) {
                    teamMembers.add(
                        widget.teamController.team[i]); // Add user to team
                  }
                }
                // Add your logic to handle team members (e.g., save to database)
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } */

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
      child: 
         RefreshIndicator(
          
    onRefresh: () async {
      // Define the logic to refresh the data here
      await widget.teamController.loadTeamMembers(); // Fetch updated data from controller
    },
    child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Team members",
                style: TextStyle(
                  fontSize: 18,
                  color: ColorManager.primary,
                ),
              ),
           /*    IconButton(
                icon: Icon(
                  Iconsax.user_cirlce_add,
                  color: ColorManager.greyText,
                  size: 30,
                ),
                onPressed: _showAddUserDialog,
              ), */
            ],
          ),
          SizedBox(height: 10),
         ListView.builder( scrollDirection: Axis.vertical,
        shrinkWrap: true,
                      itemCount: widget.teamController.team.length,
                      itemBuilder: (context, index1) {
            return Obx(() {
              var user = widget.teamController.team[index1];
              return TeamCard(
                index: index1,
                id:user.id,
                isTeamPage: true,
                type :user.type ,
                isExpanded:
                    widget.teamController.expandedCardIndex.value == index1,
                onTap: widget.teamController.toggleExpand,
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
      ), ),
    );
  }
}
