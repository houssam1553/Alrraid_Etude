import 'package:arraid/commun%20widgets/customInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/controllers/usersController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
         final navigationController = Get.put(NavigationController());

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
        onPressed: (){
              navigationController.gotoProfile();}
          
        ,
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
            costumInput(label: "0549384723"),      SizedBox(height: 5.0),                          
            costumInput(label: "example@gmail.com"),      SizedBox(height: 5.0),                          
            costumInput(label: "35 cite daib aissa"),      SizedBox(height: 5.0),                          

                                
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
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primary,
                                  ),
                                ),
                                
                              TextButton(
  onPressed: () async {
    // Find the position of the button
    final RenderBox button = context.findRenderObject() as RenderBox;
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
                                        userController.updateOrganization(widget.index, value);
                                      }
                                    });
  },
  child: 
 Obx(() {
  return Text(
    userController.users[widget.index]["organization"]!,
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