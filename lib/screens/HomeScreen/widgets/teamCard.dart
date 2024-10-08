import 'package:arraid/commun%20widgets/customInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/homeNavigationCtrl.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/controllers/teamController.dart';
import 'package:arraid/controllers/usersController.dart';
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


  final bool isExpanded;
  final Function(int) onTap; // Callback to notify parent about tap
  final int index; // Index of the card

   TeamCard({
    Key? key,
    required this.assetImage,
    required this.title,
    
    required this.subtitle,
    required this.isExpanded,
    required this.onTap,
    required this.index,
 required this.organization,
    required this.email, required this.firstName, required this.lastName, required this.isTeamPage,
  }) : super(key: key);

  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
         final navigationController = Get.put(HomeNavigationController());

  @override
  Widget build(BuildContext context) {
    final TeamController teamController = Get.find<TeamController>();
    


    bool editCard =teamController.editingCardIndex.value == widget.index;  // Check if this card is being edited

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
  width: 50, // Define a width for the container
  decoration: BoxDecoration(
    color: Colors.grey[200], // Add a background color
    borderRadius: BorderRadius.circular(50),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(50), // Match the container's border radius
    child: Image.network(
      widget.assetImage,
      fit: BoxFit.cover, // Specify how the image should fit within the container
      errorBuilder: (context, error, stackTrace) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            'Error!',
            textAlign: TextAlign.center,
          ),
        );
      },
    ),
  ),
)
,
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
                                  
            costumInput(label: widget.firstName, isEnabeled:true,),      SizedBox(height: 5.0),    
            costumInput(label: widget.lastName,isEnabeled:true,),      SizedBox(height: 5.0),                          
            costumInput(label: widget.email,isEnabeled:false,),      SizedBox(height: 5.0),                          
                                   

                                
                                ],
                              ),
                            ),
                          )],)
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
    borderRadius: BorderRadius.circular(50), // Match the container's border radius
    child: Image.network(
      widget.assetImage,
      fit: BoxFit.cover, // Specify how the image should fit within the container
      errorBuilder: (context, error, stackTrace) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            'Error!',
            textAlign: TextAlign.center,
          ),
        );
      },
    ),
  ),
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
                                    fontSize: 10.0,
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
  child: 
 Obx(() {
   final organization = teamController.team[widget.index];
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
                            TextButton(
                              onPressed: () {
                                teamController.toggleEdit(widget.index);  // Trigger edit state in controller
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