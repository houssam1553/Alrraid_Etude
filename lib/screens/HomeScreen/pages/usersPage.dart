import 'package:arraid/controllers/usersController.dart';
import 'package:arraid/screens/HomeScreen/widgets/usersContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    userController.loadUsers(); // Call to load users during initialization
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Using Obx to reactively listen for loading state changes
      if (userController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: widget.height * 0.015),
            UsersContainer(
              width: widget.width,
              height: widget.height,
              userController: userController,
            ),
          ],
        ),
      );
    });
  }
}
