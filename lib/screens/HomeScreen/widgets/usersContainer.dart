import 'package:arraid/commun%20widgets/customInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/usersController.dart';
import 'package:arraid/screens/HomeScreen/widgets/userCard.dart';
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
      "subtitle": " Software Engineer",
      "image": "assets/images/user1.png"
    },
    {
      "name": "Jane Smith",
      "email": "example@gmail.com",
      "organization": "Organization B",
      "subtitle": " Product Manager",
      "image": "assets/images/user2.png"
    },
    {
      "name": "Sam Wilson",
      "email": "example@gmail.com",
      "organization": "Organization C",
      "subtitle": " UI/UX Designer",
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







