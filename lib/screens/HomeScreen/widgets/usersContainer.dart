import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersContainer extends StatefulWidget {
  const UsersContainer({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  _UsersContainerState createState() => _UsersContainerState();
}

class _UsersContainerState extends State<UsersContainer> {
  final UserController userController = Get.put(UserController());

  final List<Map<String, String>> users = [
    {
      "name": "John Doe",
      "email": "example@gmail.com",
      "organization": "Organization A",
      "subtitle": "Software Engineer",
      "image": "assets/images/user1.png"
    },
    {
      "name": "Jane Smith",
      "email": "example@gmail.com",
      "organization": "Organization B",
      "subtitle": "Product Manager",
      "image": "assets/images/user2.png"
    },
    {
      "name": "Sam Wilson",
      "email": "example@gmail.com",
      "organization": "Organization C",
      "subtitle": "UI/UX Designer",
      "image": "assets/images/user3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.7,
      padding: EdgeInsets.symmetric(horizontal: widget.width * 0.03, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Platform users",
            style: TextStyle(
              fontSize: 18,
              color: ColorManager.primary,
            ),
          ),
          SizedBox(height: 10),
          ...List.generate(users.length, (index) {
            return Obx(() {
              return UserCard(
                index: index,
                isExpanded: userController.expandedCardIndex.value == index,
                onTap: userController.toggleExpand,
                assetImage: users[index]["image"]!,
                title: users[index]["name"]!,
                email: users[index]["email"]!,
                organization: users[index]["organization"]!,
                subtitle: users[index]["subtitle"]!,
              );
            });
          }),
        ],
      ),
    );
  }
}

class UserCard extends StatefulWidget {
  final String assetImage;
  final String title;
  final String subtitle;
  final String email;
  final String organization;

  final bool isExpanded;
  final Function(int) onTap; // Callback to notify parent about tap
  final int index; // Index of the card

  const UserCard({
    Key? key,
    required this.assetImage,
    required this.title,
    required this.subtitle,
    required this.isExpanded,
    required this.onTap,
    required this.index,
    required this.organization,
    required this.email,
  }) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    bool editCard = userController.editingCardIndex.value == widget.index;  // Check if this card is being edited

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.index),  // Notify parent about the tap (to expand/collapse)
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
               
                    editCard
                        ?  Row(
                 // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50,
                          child: Image(image: AssetImage(widget.assetImage)),
                        ),
                           Divider(
                            height: 10,
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                          color: Color(0xFFE2E8F0),
                        ),
                         Container(
  height: 60,  // You can adjust the height as needed, but 60 should be sufficient
  child: Column(
    mainAxisSize: MainAxisSize.min,  // Ensure the Column only takes up necessary space
    crossAxisAlignment: CrossAxisAlignment.start,  // Align buttons to the start
    children: [ 
      TextButton(
        onPressed: () {
          // Trigger save logic
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,  // Remove any default padding
          minimumSize: Size(0, 0),   // Reduce the size of the button
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink button hit area
        ),
        child: const Text(
          "save",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: ColorManager.primary,
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          // Trigger more logic
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,  // Remove default padding
          minimumSize: Size(0, 0),   // Reduce button size
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink hit area
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
                     SizedBox(width: 16.0), Expanded(
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  
            costumInput(label: "Zakaria BENSILLETE"),      SizedBox(height: 5.0),    
            costumInput(label: "Zakaria BENSILLETE"),      SizedBox(height: 5.0),                          
            costumInput(label: "Zakaria BENSILLETE"),      SizedBox(height: 5.0),                          
            costumInput(label: "Zakaria BENSILLETE"),      SizedBox(height: 5.0),                          

                                
                                ],
                              ),
                            ),
                          )],)
                        : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      child: Image(image: AssetImage(widget.assetImage)),
                    ),
                    const SizedBox(width: 16.0), Expanded(
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
                                    fontSize: 12.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
                if (widget.isExpanded && !editCard) ...[
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
                              children: [
                                Text(
                                  widget.subtitle,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  widget.organization,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                userController.toggleEdit(widget.index);  // Trigger edit state in controller
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

class costumInput extends StatelessWidget {
  const costumInput({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30, // Adjusted height to ensure there's enough space for the cursor and text
      child: TextFormField(
        cursorHeight: 20,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.0, // Added vertical padding to center text and cursor
            horizontal: 25.0,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          prefixIcon: null,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.labelMedium,
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}



class UserController extends GetxController {
  var expandedCardIndex = Rxn<int>();  // Index of the expanded card
  var editingCardIndex = Rxn<int>();   // Index of the editing card

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
}
