import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/controllers/profileSettingsController.dart';
import 'package:arraid/models/userListModel.dart';
import 'package:arraid/screens/LoginScreen/loginScreen.dart';
import 'package:arraid/services/localService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileSettingsForm extends StatefulWidget {
  const ProfileSettingsForm({
    super.key,
    required this.height,
    required this.width,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.id,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final double height;
  final double width;

  @override
  _ProfileSettingsFormState createState() => _ProfileSettingsFormState();
}

class _ProfileSettingsFormState extends State<ProfileSettingsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProfileSettingsController controller = Get.find<ProfileSettingsController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the passed widget data or fallback to controller state
  /*  */

    // Listen for changes in the controller's current user and update the fields accordingly
    controller.currentUser.listen((user) {
      if (user != null) {
        firstNameController.text = user.firstName ?? widget.firstName;
        lastNameController.text = user.lastName ?? widget.lastName;
        emailController.text = user.email ?? widget.email;
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    super.dispose();
  }

  Future<void> saveUser() async {
    // Update the user object with new values
    Userlistmodel updatedUser = Userlistmodel(
      id: widget.id,
      firstName: firstNameController.text.isNotEmpty ? firstNameController.text : widget.firstName,
      lastName: lastNameController.text.isNotEmpty ? lastNameController.text : widget.lastName,
      email: emailController.text.isNotEmpty ? emailController.text : widget.email,
      isEmployee: 'true',
    );

    await controller.updateUserInfo(updatedUser);
      firstNameController.text = updatedUser.firstName;
    lastNameController.text = updatedUser.lastName;
    emailController.text = widget.email;
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check if user data is available in the controller
      final user = controller.currentUser.value;

      if (user == null) {
        // If no user data is available, show a loading spinner or placeholder
        return Center(child: CircularProgressIndicator());
      }

      return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: widget.height * 0.0210),
            formInput(
              textEditingController: firstNameController,
              height: widget.height,
              label: 'First Name',
              hint: user.firstName ?? widget.firstName,
              inputType: InputType.name,
              obscureText: false,
              togglePasswordVisibility: () {},
            ),
            SizedBox(height: widget.height * 0.0210),
            formInput(
              textEditingController: lastNameController,
              height: widget.height,
              label: 'Last Name',
              hint: user.lastName ?? widget.lastName,
              inputType: InputType.name,
              obscureText: false,
              togglePasswordVisibility: () {},
            ),
            SizedBox(height: widget.height * 0.0210),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            SizedBox(height: widget.height * 0.008),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                labelText: user.email ?? widget.email,
                labelStyle: Theme.of(context).textTheme.labelMedium,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: widget.height * 0.04),
            SizedBox(
              height: widget.height * 0.0557,
              width: widget.width * 0.823,
              child: ElevatedButton(
                onPressed: () {
                  saveUser();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Apply changes",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    controller.saveLoading.value
                        ?  Center(
                                              child: SizedBox(
                                                  width: 15,
                                                  height: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                    color: ColorManager.white,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  )))
                        : Icon(Iconsax.document_upload),
                  ],
                ),
              ),
            ),
            SizedBox(height: widget.height * 0.025),
            SizedBox(
              height: widget.height * 0.0557,
              width: widget.width * 0.823,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                ),
                onPressed: () {
                 controller.logout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Log out",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.black
                                : Colors.white,
                          ),
                    ),
                    SizedBox(width: 10), controller.logoutLoading.value
                        ?  Center(
                                              child: SizedBox(
                                                  width: 15,
                                                  height: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                    color: ColorManager.white,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  )))
                        :
                    Icon(Icons.logout),
                  ],
                ),
              ),
            ),
            SizedBox(height: widget.height * 0.0357),
          ],
        ),
      );
    });
  }
}
