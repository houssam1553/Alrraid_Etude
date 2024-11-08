import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/controllers/profileSettingsController.dart';
import 'package:arraid/screens/HomeScreen/widgets/profileSettForm.dart';
import 'package:arraid/screens/HomeScreen/widgets/settingSection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingsTab extends StatefulWidget {
  const ProfileSettingsTab({super.key});

  @override
  State<ProfileSettingsTab> createState() => _ProfileSettingsTabState();
}

class _ProfileSettingsTabState extends State<ProfileSettingsTab> {
  final ProfileSettingsController controller =
      Get.find<ProfileSettingsController>();
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    // Fetch current user data on initialization
     controller.loadImage();
    controller.fetchCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      body: DefaultTabController(
        length: 2,
        child: Container(
          padding: EdgeInsets.only(
            top: height * 0.0956,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                Obx(() {
  return SizedBox(
    width: 120,
    height: 120,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100),  // Circular shape
      child: controller.profileImage.value != null
          ? Image.file(controller.profileImage.value!)  // Display the profile image
          : Image.asset('assets/images/profilePic.png'),  // Fallback image if no profile image
    ),
  );
}),

                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorManager.primary,
                      ),
                      width: 30,
                      height: 30,
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                           await controller.pickImage(ImageSource.gallery);
                          },
                          icon: const Icon(
                            Iconsax.edit,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 27), // Space between avatar and TabBar
              TabBar(
                dividerColor: Colors.transparent,
                indicatorColor: ColorManager.primary, // Removes the underline
                tabs: [
                  Tab(
                    child: Text(
                      "Personal",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorManager.primary),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Security",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorManager.primary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Optional space between TabBar and TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: Obx(() {
                            // Check if the observable currentUser is null
                            if (controller.currentUser == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              // Display the form when currentUser is available
                              return ProfileSettingsForm(
                                height: height,
                                width: width,
                                id: controller.currentUser.value?.id ?? 'id',
                                firstName:
                                    controller.currentUser.value?.firstName ??
                                        'First Name', // Fallback if null
                                lastName:
                                    controller.currentUser.value?.lastName ??
                                        'Last Name',
                                email:
                                    controller.currentUser.value?.email ??
                                        'email', // Fallback if null
                              );
                            }
                          }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 13),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              settingsSection(
                                width: width,
                                title: "Change password",
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: height * 0.008),
                 formInput(
                                        height: height,
                                        label: "Current password",
                                        hint: "Enter your current password",
                                        inputType: InputType.name
                                        ,
                                        obscureText: false,
                                        togglePasswordVisibility:
                                            controller.togglePasswordVisibility,
                                            textEditingController: controller. currentPasswordController,
                                      
                                      ),
                                    
                                      SizedBox(height: height * 0.0309),
                                      formInput(
                                        height: height,
                                        label: "Password",
                                        hint: "Enter your password",
                                        inputType: InputType.passwordCh,
                                        obscureText: false,
                                        togglePasswordVisibility:
                                            controller.togglePasswordVisibility,
                                            textEditingController: controller. passwordController,
                                        passwordController: controller. passwordController,
                                      ),
                                      SizedBox(height: height * 0.0309),
                                      formInput(
                                        height: height,
                                        label: "Repeat password",
                                        hint: "Password again",
                                        inputType: InputType.passwordChRepeat,
                                        obscureText: false,
                                      
                                        togglePasswordVisibility:
                                            controller.togglePasswordVisibility,
                                       textEditingController: controller. confirmPasswordController, // Pass the confirm password controller here
  passwordController: controller. passwordController, // Pass the main password controller for comparison
),
                                    ],
                                  ),
                                  
                                ),
                              ),
                              SizedBox(height: height * 0.04),
                              SizedBox(
                                height: height * 0.0557,
                                width: width * 0.63,
                                child: Obx(() {
                                  
                                  return ElevatedButton(
                                  onPressed: () async {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      // Trigger logic when the form is valid

                                    
                               await       controller.updateUserPassword(userId: controller.currentUser.value!.clerkId , currentPassword: controller. currentPasswordController.text, newPassword:controller. passwordController.text);


                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Apply changes",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    controller.changePassLoading.value
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
                                );}),
                              ),
                              SizedBox(
                                height: height * 0.0357,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
