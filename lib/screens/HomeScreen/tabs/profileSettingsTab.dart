import 'package:arraid/config/colors.dart';
import 'package:arraid/screens/HomeScreen/widgets/profileSettForm.dart';
import 'package:arraid/screens/HomeScreen/widgets/settingSection.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileSettingsTab extends StatefulWidget {
  const ProfileSettingsTab({super.key});

  @override
  State<ProfileSettingsTab> createState() => _ProfileSettingsTabState();
}

class _ProfileSettingsTabState extends State<ProfileSettingsTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      body: DefaultTabController(
        length: 3,
        child: Container(
          padding: EdgeInsets.only(
            top: height * 0.0956,
           
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/profile.png',
                      ),
                    ),
                  ),
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
                          onPressed: () {},
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold,color: ColorManager.primary)
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Security",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold,color: ColorManager.primary)
                    ),
                  ),
                 
                ],
              ),
               SizedBox(height: 20,),
             // Optional space between TabBar and TabBarView
               Expanded( // Use Expanded to ensure TabBarView fills available space
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 13)
                          ,
                           child: ProfileSettingsForm(height: height, width: width),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Container(padding: EdgeInsets.symmetric(horizontal: 13),
                          child: Column(
                            children: [
                                 SizedBox(height: 10,),
                             
                     settingsSection(width: width,title: "Privacy settings",child: Column(
          children: [
                            switchText(label: "Let others see my profile",),
                            switchText(label: "Let others see my profile",),
                            switchText(label: "Let others see my profile",),
                            switchText(label: "Let others see my profile",),

          ],
        ),),
     SizedBox(height: 30,),
                     settingsSection(width: width,title: "Change password",child: Column(
                      children: <Widget>[
                            SizedBox(height: height * 0.008),
                        Align(
                          alignment:
                              Alignment.centerLeft, // Align text to the left
                          child: Text(
                            " Current password",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        TextFormField(
                          //controller: loginController.emailController,
                          // validator: (value) => Validator.validateEmail(value), // Use email validator
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 15),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              prefixIcon: null,
                              labelText: " Enter your current password",
                              labelStyle: Theme.of(context).textTheme.labelMedium
                              /*  TextStyle(
                                    
                                  //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                  ),
                                   */
                              ),
                        
                        ),                       
                          SizedBox(height: height * 0.0309
),
                       
             
                        Align(
                          alignment:
                              Alignment.centerLeft, // Align text to the left
                          child: Text(
                            " Password",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        TextFormField(
                          //controller: loginController.emailController,
                          // validator: (value) => Validator.validateEmail(value), // Use email validator
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 15),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              prefixIcon: null,
                              labelText: "  Enter your new password",
                              labelStyle: Theme.of(context).textTheme.labelMedium
                              /*  TextStyle(
                                    
                                  //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                  ),
                                   */
                              ),
                        
                        ),                       
                          SizedBox(height: height * 0.0309
),   Align(
                          alignment:
                              Alignment.centerLeft, // Align text to the left
                          child: Text(
                            " Repeat password",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        TextFormField(
                          //controller: loginController.emailController,
                          // validator: (value) => Validator.validateEmail(value), // Use email validator
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 15),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              prefixIcon: null,
                              labelText: " Password again",
                              labelStyle: Theme.of(context).textTheme.labelMedium
                              /*  TextStyle(
                                    
                                  //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                  ),
                                   */
                              ),
                        
                        ),           
                      
                       
                      ],),),
                       SizedBox(height: height * 0.04),
            SizedBox(
                    height: height * 0.0557,
                    width: width * 0.63,
                    child: ElevatedButton(
                      onPressed:(){},
                      child: Text(
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
                      
                    ),
                  ),
                  SizedBox(   height: height * 0.0357,),

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

