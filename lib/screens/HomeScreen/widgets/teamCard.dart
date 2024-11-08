import 'package:arraid/commun%20widgets/customInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/homeNavigationCtrl.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/controllers/teamController.dart';
import 'package:arraid/controllers/usersController.dart';
import 'package:arraid/models/userListModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamCard extends StatefulWidget {
  final String assetImage;
  final String title;
  final String firstName;
  final String lastName;

  final String subtitle;
  final String email;
  final String organization;
  final bool isTeamPage;
  final String id;
  final VoidCallback onRefresh;
  bool isExpanded;
  bool editCard;
  final Function(int) onTap; // Callback to notify parent about tap
  final int index; // Index of the card

  TeamCard({
    Key? key,
    required this.assetImage,
    required this.title,
    required this.subtitle,
    required this.isExpanded,
    required this.editCard,
    required this.onTap,
    required this.index,
    required this.organization,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isTeamPage,
    required this.id,
    String? type,
    required this.onRefresh,
  }) : super(key: key);

  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  final navigationController = Get.put(HomeNavigationController());
  final TeamController teamController = Get.find<TeamController>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    /*    setState(() {
    widget.isExpanded = false;
    widget.editCard = false;

     

  // Collapse the card
  }); */
   

    // Initialize the controllers with existing user data

    firstNameController.text = widget.firstName;
    lastNameController.text = widget.lastName;
    emailController.text = widget.email;
    super.initState();
  }

  @override
  void dispose() {
    // Reset the editing state if this card is being edited
    if (teamController.editingCardIndex.value == widget.index) {
      teamController.editingCardIndex.value =
          -1; // Reset to no card being edited
    }

    widget.editCard = false;

    //  teamController.isLoading.value = false;
    // Dispose controllers to free resources
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> saveUser() async {
    // Update the user object with new values
    Userlistmodel updatedUser = Userlistmodel(
      id: widget.id,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      isEmployee: 'true', // Or retain the existing value
    );
    //print(updatedUser.firstName);
    // Update the user in the controller
   
    await teamController.updateUserInfo(updatedUser);
    teamController.loadTeamMembers();
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      widget.isExpanded = false;
      widget.editCard = false;

      // Collapse the card
    });
    teamController.editingCardIndex.value = -1;
    widget.onRefresh();
  }

  Future<void> deleteUser() async {
    // Update the user object with new values
   // print(" isExpanded : ${widget.isExpanded}");
    //teamController.isLoading.value = true;
    // Update the user in the controller
    await teamController.deleteUser(widget.id);
    teamController.loadTeamMembers();
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      widget.isExpanded = false;
    });
    teamController.editingCardIndex.value = -1;
  }

  @override
  Widget build(BuildContext context) {
    // bool editCard =teamController.editingCardIndex.value == widget.index;
    // Check if this card is being edited

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: () => widget.onTap(
            widget.index), // Notify parent about the tap (to expand/collapse)
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 100, 70, 70).withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(1, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Column(
              children: [
                widget.editCard
                    ? Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 50,
                                width: 50, // Define a width for the container
                                decoration: BoxDecoration(
                                  color: Colors
                                      .grey[200], // Add a background color
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.isExpanded = false;
                                    });
                                    teamController.editingCardIndex.value = -1;
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        50), // Match the container's border radius
                                    child: Image.network(
                                      widget.assetImage,
                                      fit: BoxFit
                                          .cover, // Specify how the image should fit within the container
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                                "assets/images/arraidLogo.png"));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 10,
                                indent: 10,
                                endIndent: 10,
                                thickness: 1,
                                color: Color(0xFFE2E8F0),
                              ),
                              Container(
                                height:
                                    60, // You can adjust the height as needed, but 60 should be sufficient
                                child: Column(
                                  mainAxisSize: MainAxisSize
                                      .min, // Ensure the Column only takes up necessary space
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align buttons to the start
                                  children: [
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            // Trigger save logic
                                            saveUser();
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets
                                                .zero, // Remove any default padding
                                            minimumSize: Size(0,
                                                0), // Reduce the size of the button
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap, // Shrink button hit area
                                          ),
                                          child: const Text(
                                            "save  ",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.primary,
                                            ),
                                          ),
                                        ),
                                         Obx(() {
                                      return teamController.saveLoading.value
                                          ? Center(
                                              child: SizedBox(
                                                  width: 12,
                                                  height: 12,
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                    color: ColorManager.primary,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  )))
                                          : SizedBox.shrink();
                                    })
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        teamController.currentTeamMember =widget.firstName+' '+widget.lastName;
                                        navigationController.gotoProfile();
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets
                                            .zero, // Remove default padding
                                        minimumSize:
                                            Size(0, 0), // Reduce button size
                                        tapTargetSize: MaterialTapTargetSize
                                            .shrinkWrap, // Shrink hit area
                                      ),
                                      child: const Text(
                                        "more",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  costumInput(
                                    controller: firstNameController,
                                    label: widget.firstName,
                                    isEnabeled: true,
                                  ),
                                  SizedBox(height: 5.0),
                                  costumInput(
                                    controller: lastNameController,
                                    label: widget.lastName,
                                    isEnabeled: true,
                                  ),
                                  SizedBox(height: 5.0),
                                  costumInput(
                                    controller: emailController,
                                    label: widget.email,
                                    isEnabeled: false,
                                  ),
                                  SizedBox(height: 5.0),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50, // Define a width for the container
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Add a background color
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  50), // Match the container's border radius
                              child: Image.network(
                                widget.assetImage,
                                fit: BoxFit
                                    .cover, // Specify how the image should fit within the container
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                          "assets/images/arraidLogo.png"));
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  widget.email,
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                if (widget.isExpanded && !widget.editCard) ...[
                  // Expanded content only shows if not in edit mode
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        const Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.5,
                          color: Color(0xFFE2E8F0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  widget.subtitle,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primary,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Find the position of the button
                                    /*    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonPosition = button.localToGlobal(Offset.zero);

    // Show the menu at the button's position
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx, // X position
        buttonPosition.dy + button.size.height -27, // Y position (below the button)
        buttonPosition.dx + button.size.width, // Width
        buttonPosition.dy, // Height (for reference)
      ),
          items: [
                                        PopupMenuItem(
                                          value: "Organization A",
                                          child: Text('Organization A'),
                                        ),
                                        PopupMenuItem(
                                          value: "Organization B",
                                          child: Text('Organization B'),
                                        ),
                                        PopupMenuItem(
                                          value: "Organization C",
                                          child: Text('Organization C'),
                                        ),
                                      ],
                                    ).then((value) {
                                      if (value != null) {
                                      //  teamController.updateOrganization(widget.index, value);
                                      }
                                    }); */
                                  },
                                  child: Obx(() {
                                    final organization =
                                        teamController.team[widget.index];
                                    return Text(
                                      widget.organization,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.greyText,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    teamController.toggleEdit(widget
                                        .index); // Trigger edit state in controller
                                  },
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        deleteUser(); // Trigger edit state in controller
                                      },
                                      child: const Text(
                                        "Delete ",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 224, 83, 83),
                                        ),
                                      ),
                                    ),
                                    Obx(() {
                                      return teamController.deleteLoading.value
                                          ? Center(
                                              child: SizedBox(
                                                  width: 15,
                                                  height: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color.fromARGB(
                                                        255, 224, 83, 83),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  )))
                                          : SizedBox.shrink();
                                    })
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
